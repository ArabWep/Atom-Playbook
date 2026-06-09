# WALLPAPER-APPLY.ps1 - Privacy+ exact method (registry-only, no SystemParametersInfo)
# Called by 09-wallpaper.yml via !run with exeDir: true
# Matches https://github.com/Ameliorated-LLC/privacy_plus/blob/public/src/Executables/WALLPAPER.bat

$ErrorActionPreference = 'SilentlyContinue'

# ═══════════════════════════════════════════════════════════
# STEP 1: CONVERT PNG TO BMP AND JPG
# ═══════════════════════════════════════════════════════════
Write-Host "Converting wallpaper images..."

$scriptDir = $PSScriptRoot
$imagesDir = Join-Path $scriptDir '..\Images'
$srcPng = Join-Path $imagesDir 'img0.png'

if (-not (Test-Path $srcPng)) {
    Write-Host "ERROR: Source image not found at $srcPng"
    exit 1
}

Add-Type -AssemblyName System.Drawing
$img = [System.Drawing.Image]::FromFile($srcPng)

$bmp = New-Object System.Drawing.Bitmap($img)
$bmp.Save((Join-Path $scriptDir 'ame_wallpaper_4K.bmp'), [System.Drawing.Imaging.ImageFormat]::Bmp)
$bmp.Save((Join-Path $scriptDir 'img0.jpg'), [System.Drawing.Imaging.ImageFormat]::Jpeg)
$bmp.Save((Join-Path $scriptDir 'img0_1920x1200.jpg'), [System.Drawing.Imaging.ImageFormat]::Jpeg)
$bmp.Save((Join-Path $scriptDir 'img0_3840x2160.jpg'), [System.Drawing.Imaging.ImageFormat]::Jpeg)
$bmp.Save((Join-Path $scriptDir 'img0_1920x1080.jpg'), [System.Drawing.Imaging.ImageFormat]::Jpeg)
$bmp.Save((Join-Path $scriptDir 'img100.jpg'), [System.Drawing.Imaging.ImageFormat]::Jpeg)
$bmp.Dispose()
$img.Dispose()
Write-Host "Converted all images"

# ═══════════════════════════════════════════════════════════
# STEP 2: MOVE BMP TO SYSTEM DIRECTORY (Privacy+ exact)
# ═══════════════════════════════════════════════════════════
$wallpaperDir = Join-Path $env:SystemRoot 'Web\Wallpaper\Windows'
if (-not (Test-Path $wallpaperDir)) { New-Item -Path $wallpaperDir -ItemType Directory -Force | Out-Null }

$bmpSrc = Join-Path $scriptDir 'ame_wallpaper_4K.bmp'
$bmpDest = Join-Path $wallpaperDir 'ame_wallpaper_4K.bmp'
if (Test-Path $bmpSrc) {
    Copy-Item $bmpSrc $bmpDest -Force
    & icacls.exe $bmpDest /reset 2>$null
}
Write-Host "BMP copied to $bmpDest"

# ═══════════════════════════════════════════════════════════
# STEP 3: COPY JPGS TO SYSTEM DIRECTORIES (Privacy+ exact)
# ═══════════════════════════════════════════════════════════
$jpg4k = Join-Path $env:SystemRoot 'Web\4K\Wallpaper\Windows'
if (-not (Test-Path $jpg4k)) { New-Item -Path $jpg4k -ItemType Directory -Force | Out-Null }

# Copy img0_*.jpg to 4K directory
$jpgFiles = @('img0_1920x1200.jpg', 'img0_3840x2160.jpg', 'img0_1920x1080.jpg')
foreach ($f in $jpgFiles) {
    $src = Join-Path $scriptDir $f
    $dst = Join-Path $jpg4k $f
    if (Test-Path $src) {
        & icacls.exe $dst /reset 2>$null
        Copy-Item $src $dst -Force
    }
}

# Copy img0.jpg to Wallpaper\Windows and 4K
$img0jpg = Join-Path $scriptDir 'img0.jpg'
if (Test-Path $img0jpg) {
    $dst1 = Join-Path $wallpaperDir 'img0.jpg'
    & icacls.exe $dst1 /reset 2>$null
    Copy-Item $img0jpg $dst1 -Force

    $dst2 = Join-Path $jpg4k 'img0_1920x1200.jpg'
    & icacls.exe $dst2 /reset 2>$null
    Copy-Item $img0jpg $dst2 -Force
}

# Copy to Spotlight directory
$spotlightDir = Join-Path $env:SystemRoot 'Web\Wallpaper\Spotlight'
if (-not (Test-Path $spotlightDir)) { New-Item -Path $spotlightDir -ItemType Directory -Force | Out-Null }
$spotlightDst = Join-Path $spotlightDir 'img14.jpg'
& icacls.exe $spotlightDst /reset 2>$null
if (Test-Path $img0jpg) { Copy-Item $img0jpg $spotlightDst -Force }

# Copy lock screen image
$screenDir = Join-Path $env:SystemRoot 'Web\Screen'
if (-not (Test-Path $screenDir)) { New-Item -Path $screenDir -ItemType Directory -Force | Out-Null }
$img100 = Join-Path $scriptDir 'img100.jpg'
$screenDst = Join-Path $screenDir 'img100.jpg'
& icacls.exe $screenDst /reset 2>$null
if (Test-Path $img100) { Copy-Item $img100 $screenDst -Force }
Write-Host "All JPGs copied to system directories"

# ═══════════════════════════════════════════════════════════
# STEP 4: MODIFY AERO.THEME (Privacy+ exact)
# ═══════════════════════════════════════════════════════════
$themePath = Join-Path $env:SystemRoot 'Resources\Themes\aero.theme'
if (Test-Path $themePath) {
    & icacls.exe $themePath /reset 2>$null

    $content = Get-Content $themePath -Raw
    $content = $content -replace 'Wallpaper=%%SystemRoot%%.*', "Wallpaper=$env:SystemRoot\web\wallpaper\Windows\ame_wallpaper_4K.bmp"
    $content = $content -replace 'SystemMode=.*', 'SystemMode=Dark'
    $content = $content -replace 'AppMode=.*', 'AppMode=Light'
    $content | Set-Content $themePath -Force
    Write-Host "Modified aero.theme"
}

# ═══════════════════════════════════════════════════════════
# STEP 5: PER-USER WALLPAPER (Privacy+ registry-only method)
# ═══════════════════════════════════════════════════════════
$wallpaper = Join-Path $env:SystemRoot 'Web\Wallpaper\Windows\ame_wallpaper_4K.bmp'

# Get all user SIDs (same as WALLPAPER.bat)
$sids = @()
Get-ChildItem 'Registry::HKEY_USERS' -ErrorAction SilentlyContinue | Where-Object {
    $_.PSChildName -match '^S-1-5-21' -or $_.PSChildName -match '^AME_UserHive_[^_]'
} | ForEach-Object { $sids += $_.PSChildName }

foreach ($sid in $sids) {
    Write-Host "Processing SID: $sid"

    # Disable Spotlight collection on desktop
    $cloudPolicy = "Registry::HKEY_USERS\$sid\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
    if (-not (Test-Path $cloudPolicy)) { New-Item -Path $cloudPolicy -Force | Out-Null }
    Set-ItemProperty -Path $cloudPolicy -Name 'DisableSpotlightCollectionOnDesktop' -Value 1 -Type DWord -Force

    # Check for Transcoded_000 (skip wallpaper if exists - Privacy+ behavior)
    $shellFolders = "Registry::HKEY_USERS\$sid\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders"
    $appDataPath = ''
    if (Test-Path $shellFolders) {
        $appDataPath = (Get-ItemProperty -Path $shellFolders -Name 'AppData' -ErrorAction SilentlyContinue).AppData
    }
    if (-not $appDataPath) {
        $appDataPath = Join-Path $env:SystemDrive "Users\$sid\AppData\Roaming"
    }

    $transcoded000 = Join-Path $appDataPath "Microsoft\Windows\Themes\Transcoded_000"
    if (Test-Path $transcoded000) {
        Write-Host "Transcoded_000 exists, skipping wallpaper for $sid"
    } else {
        # Check if Spotlight is currently enabled
        $spotlightSettings = "Registry::HKEY_USERS\$sid\SOFTWARE\Microsoft\Windows\CurrentVersion\DesktopSpotlight\Settings"
        $spotlightEnabled = $false
        if (Test-Path $spotlightSettings) {
            $enabledState = (Get-ItemProperty -Path $spotlightSettings -Name 'EnabledState' -ErrorAction SilentlyContinue).EnabledState
            if ($enabledState -eq 1) { $spotlightEnabled = $true }
        }

        if (-not $spotlightEnabled) {
            # Check if current wallpaper is NOT Spotlight
            $desktopKey = "Registry::HKEY_USERS\$sid\Control Panel\Desktop"
            $currentWall = ''
            if (Test-Path $desktopKey) {
                $currentWall = (Get-ItemProperty -Path $desktopKey -Name 'WallPaper' -ErrorAction SilentlyContinue).WallPaper
            }
            if ($currentWall -notlike '*DesktopSpotlight*') {

                # ─── SET WALLPAPER VIA REGISTRY (Privacy+ exact method) ───
                if (Test-Path $desktopKey) {
                    Set-ItemProperty -Path $desktopKey -Name 'WallPaper' -Value $wallpaper -Force
                }
                Write-Host "Set WallPaper registry for $sid"

                # Disable DesktopSpotlight
                if (-not (Test-Path $spotlightSettings)) { New-Item -Path $spotlightSettings -Force | Out-Null }
                Set-ItemProperty -Path $spotlightSettings -Name 'EnabledState' -Value 0 -Type DWord -Force

                # Set BackgroundType=0
                $wallpapers = "Registry::HKEY_USERS\$sid\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Wallpapers"
                if (-not (Test-Path $wallpapers)) { New-Item -Path $wallpapers -Force | Out-Null }
                Set-ItemProperty -Path $wallpapers -Name 'BackgroundType' -Value 0 -Type DWord -Force
                Set-ItemProperty -Path $wallpapers -Name 'CurrentWallpaperPath' -Value $wallpaper -Type String -Force

                # Delete TranscodedWallpaper cache (forces re-read on next logon)
                $transcoded = Join-Path $appDataPath "Microsoft\Windows\Themes\TranscodedWallpaper"
                if (Test-Path $transcoded) { Remove-Item $transcoded -Force }
                $cachedFiles = Join-Path $appDataPath "Microsoft\Windows\Themes\CachedFiles"
                if (Test-Path $cachedFiles) { Remove-Item $cachedFiles -Recurse -Force }
                Write-Host "Cleared wallpaper cache for $sid"
            }
        }
    }

    # Lock screen cleanup (Privacy+ method)
    # Disable lock screen spotlight
    $contentDelivery = "Registry::HKEY_USERS\$sid\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
    if (Test-Path $contentDelivery) {
        Set-ItemProperty -Path $contentDelivery -Name 'RotatingLockScreenEnabled' -Value 0 -Type DWord -Force
        Set-ItemProperty -Path $contentDelivery -Name 'RotatingLockScreenOverlayEnabled' -Value 0 -Type DWord -Force
        Set-ItemProperty -Path $contentDelivery -Name 'SubscribedContent-338387Enabled' -Value 0 -Type DWord -Force
        Set-ItemProperty -Path $contentDelivery -Name 'SubscribedContent-353694Enabled' -Value 0 -Type DWord -Force
        Set-ItemProperty -Path $contentDelivery -Name 'SubscribedContent-353696Enabled' -Value 0 -Type DWord -Force
        Set-ItemProperty -Path $contentDelivery -Name 'SubscribedContent-310093Enabled' -Value 0 -Type DWord -Force
        Set-ItemProperty -Path $contentDelivery -Name 'SystemPaneSuggestionsEnabled' -Value 0 -Type DWord -Force
    }

    # Lock screen registry HKLM
    $logonUI = "Registry::HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\Creative\$sid"
    if (-not (Test-Path $logonUI)) { New-Item -Path $logonUI -Force | Out-Null }
    Set-ItemProperty -Path $logonUI -Name 'RotatingLockScreenEnabled' -Value 0 -Type DWord -Force

    # Clear lock screen cache (Privacy+ method)
    $systemData = Join-Path $env:ProgramData 'Microsoft\Windows\SystemData'
    if (Test-Path $systemData) {
        & takeown.exe /R /D Y /F $systemData 2>$null
        & icacls.exe $systemData /reset /t 2>$null
        Get-ChildItem "$systemData\*\ReadOnly\LockScreen_*" -Directory -ErrorAction SilentlyContinue | ForEach-Object {
            Remove-Item $_.FullName -Recurse -Force -ErrorAction SilentlyContinue
        }
    }
}
Write-Host "Wallpaper applied to $($sids.Count) user profiles"

# ═══════════════════════════════════════════════════════════
# STEP 6: START MENU CLEANUP
# ═══════════════════════════════════════════════════════════
Write-Host "Cleaning start menu..."

$startMenuFolders = @(
    "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Windows Accessories",
    "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Windows Accessories\System Tools",
    "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Windows Administrative Tools",
    "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Windows Ease of Access",
    "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Windows PowerShell",
    "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories",
    "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories\Windows PowerShell",
    "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Windows Accessories",
    "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Windows Accessories\System Tools",
    "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Windows Administrative Tools",
    "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Windows Ease of Access",
    "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Windows PowerShell",
    "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Accessories",
    "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Accessories\Windows PowerShell"
)
foreach ($f in $startMenuFolders) {
    if (Test-Path $f) { Remove-Item $f -Recurse -Force; Write-Host "Deleted: $f" }
}

# ═══════════════════════════════════════════════════════════
# STEP 7: SCHOOL ESSENTIALS + PINNED ITEMS + CONTENT DELIVERY
# ═══════════════════════════════════════════════════════════
Write-Host "Removing School Essentials and pinned items..."

# Disable CloudContent pinned items
$cloudPolicy = "Registry::HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
if (-not (Test-Path $cloudPolicy)) { New-Item -Path $cloudPolicy -Force | Out-Null }
Set-ItemProperty -Path $cloudPolicy -Name 'DisableSoftLanding' -Value 1 -Type DWord -Force
Set-ItemProperty -Path $cloudPolicy -Name 'DisableWindowsSpotlightFeatures' -Value 1 -Type DWord -Force
Set-ItemProperty -Path $cloudPolicy -Name 'DisableConsumerFeatures' -Value 1 -Type DWord -Force
Set-ItemProperty -Path $cloudPolicy -Name 'DisableCloudOptimizedContent' -Value 1 -Type DWord -Force

# Remove pinned items from all user hives
Get-ChildItem 'Registry::HKEY_USERS' -ErrorAction SilentlyContinue | Where-Object {
    $_.PSChildName -match '^S-1-5-21'
} | ForEach-Object {
    $sid = $_.PSChildName

    # Clear CloudStore pinned items
    $cloudStore = "Registry::HKEY_USERS\$sid\SOFTWARE\Microsoft\Windows\CurrentVersion\CloudStore\Store\DefaultAccount\Current"
    if (Test-Path $cloudStore) {
        Remove-ItemProperty -Path $cloudStore -Name 'default' -Force -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path $cloudStore -Name 'current' -Force -ErrorAction SilentlyContinue
    }

    # Disable pinned apps provider
    $pinnedApps = "Registry::HKEY_USERS\$sid\SOFTWARE\Microsoft\Windows\CurrentVersion\CloudStore\Store\DefaultAccount\Current\default`$Windows.Taskbar.Datastore"
    if (Test-Path $pinnedApps) { Remove-Item -Path $pinnedApps -Recurse -Force }

    # Remove StartMenu pinned items
    $startPinned = "Registry::HKEY_USERS\$sid\SOFTWARE\Microsoft\Windows\CurrentVersion\CloudStore\Store\DefaultAccount\Current\default`$Windows.Start.PinnedApps.Datastore"
    if (Test-Path $startPinned) { Remove-Item -Path $startPinned -Recurse -Force }

    # Disable ContentDeliveryManager suggestions
    $cdm = "Registry::HKEY_USERS\$sid\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
    if (Test-Path $cdm) {
        Set-ItemProperty -Path $cdm -Name 'RotatingLockScreenEnabled' -Value 0 -Type DWord -Force
        Set-ItemProperty -Path $cdm -Name 'RotatingLockScreenOverlayEnabled' -Value 0 -Type DWord -Force
        Set-ItemProperty -Path $cdm -Name 'SubscribedContent-338387Enabled' -Value 0 -Type DWord -Force
        Set-ItemProperty -Path $cdm -Name 'SubscribedContent-353694Enabled' -Value 0 -Type DWord -Force
        Set-ItemProperty -Path $cdm -Name 'SubscribedContent-353696Enabled' -Value 0 -Type DWord -Force
        Set-ItemProperty -Path $cdm -Name 'SubscribedContent-310093Enabled' -Value 0 -Type DWord -Force
        Set-ItemProperty -Path $cdm -Name 'SystemPaneSuggestionsEnabled' -Value 0 -Type DWord -Force
        Set-ItemProperty -Path $cdm -Name 'FeatureManagementEnabled' -Value 0 -Type DWord -Force
        Set-ItemProperty -Path $cdm -Name 'OemPreInstalledAppsEnabled' -Value 0 -Type DWord -Force
        Set-ItemProperty -Path $cdm -Name 'PreInstalledAppsEnabled' -Value 0 -Type DWord -Force
        Set-ItemProperty -Path $cdm -Name 'SilentInstalledAppsEnabled' -Value 0 -Type DWord -Force
    }
}

# ═══════════════════════════════════════════════════════════
# STEP 8: REMOVE BLOAT SHORTCUTS + SCHOOL ESSENTIALS + EDGE
# ═══════════════════════════════════════════════════════════
Write-Host "Removing bloat shortcuts..."

$startMenuDirs = @(
    "$env:ProgramData\Microsoft\Windows\Start Menu\Programs"
    "$env:APPDATA\Microsoft\Windows\Start Menu\Programs"
)

# Delete known bloat folders (including School Essentials and Microsoft Edge)
$bloatFolders = @(
    '3D Viewer', 'Accessories', 'Administrative Tools', 'Accessibility',
    'Maintenance', 'Microsoft Edge', 'Microsoft Office', 'OneDrive',
    'OneNote', 'Outlook', 'Paint 3D', 'Photos', 'Skype',
    'School Essentials',
    'Windows Accessories', 'Windows Administrative Tools',
    'Windows Ease of Access', 'Windows PowerShell',
    'Windows System', 'Windows System Tools'
)
foreach ($base in $startMenuDirs) {
    foreach ($f in $bloatFolders) {
        $path = Join-Path $base $f
        if (Test-Path $path) { Remove-Item $path -Recurse -Force; Write-Host "Deleted folder: $path" }
    }
}

# Delete known bloat .lnk files
$bloatShortcuts = @(
    'Get Help.lnk', 'Tips.lnk', 'Feedback Hub.lnk', 'Get Started.lnk',
    'Microsoft Edge.lnk', 'Notepad.lnk', 'Paint.lnk', 'Snipping Tool.lnk',
    'Windows Media Player.lnk', 'Xbox.lnk', 'Solitaire Collection.lnk',
    'Alarms & Clock.lnk', 'Calculator.lnk', 'Calendar.lnk', 'Camera.lnk',
    'Mail.lnk', 'Maps.lnk', 'Movies & TV.lnk', 'Groove Music.lnk',
    'People.lnk', 'Phone Link.lnk', 'Sticky Notes.lnk', 'Weather.lnk',
    'Windows Security.lnk', 'Power Automate.lnk', 'To Do.lnk',
    'Copilot.lnk', 'Microsoft Teams.lnk', 'Clipchamp.lnk',
    'Word.lnk', 'Excel.lnk', 'PowerPoint.lnk', 'OneNote.lnk',
    'Outlook.lnk', 'Publisher.lnk', 'Access.lnk',
    'Microsoft Edge.lnk'
)
foreach ($base in $startMenuDirs) {
    foreach ($lnk in $bloatShortcuts) {
        $path = Join-Path $base $lnk
        if (Test-Path $path) { Remove-Item $path -Force; Write-Host "Deleted shortcut: $path" }
    }
    # Also check Accessories subfolder
    $accessories = Join-Path $base 'Accessories'
    if (Test-Path $accessories) {
        foreach ($lnk in $bloatShortcuts) {
            $path = Join-Path $accessories $lnk
            if (Test-Path $path) { Remove-Item $path -Force }
        }
    }
}

Write-Host "Bloat shortcuts removed."

# ═══════════════════════════════════════════════════════════
# STEP 9: CLEANUP TEMP FILES
# ═══════════════════════════════════════════════════════════
$cleanupFiles = @(
    (Join-Path $scriptDir 'ame_wallpaper_4K.bmp'),
    (Join-Path $scriptDir 'img0.jpg'),
    (Join-Path $scriptDir 'img0_1920x1200.jpg'),
    (Join-Path $scriptDir 'img0_3840x2160.jpg'),
    (Join-Path $scriptDir 'img0_1920x1080.jpg'),
    (Join-Path $scriptDir 'img100.jpg')
)
foreach ($f in $cleanupFiles) {
    if (Test-Path $f) { Remove-Item $f -Force }
}

Write-Host "Wallpaper and start menu cleanup complete."
