# CLEANUP.ps1 - Comprehensive disk cleanup
# Called by 10-final.yml via NSudoLC (TrustedInstaller)
# Combines: OneDrive removal, reserved storage, paging, WinRE, disk cleanup, WinSxS, hibernation

param(
    [switch]$FullWinSxS  # When true, also run /ResetBase for maximum WinSxS savings
)

$ErrorActionPreference = 'SilentlyContinue'

# ═══════════════════════════════════════════════════════════
# FULL ONEDRIVE REMOVAL
# ═══════════════════════════════════════════════════════════
Write-Host "=== FULL ONEDRIVE REMOVAL ==="

# Kill OneDrive processes
Get-Process -Name OneDrive -Force | Stop-Process -Force
Get-Process -Name OneDriveStandaloneUpdater -Force | Stop-Process -Force
Get-Process -Name OneDriveSetup -Force | Stop-Process -Force

# Discover ALL setup paths - checks per-user registry
$setupPaths = @(
    "$env:SystemRoot\System32\OneDriveSetup.exe",
    "$env:SystemRoot\SysWOW64\OneDriveSetup.exe"
)

# Check per-user uninstall entries
Get-ChildItem 'Registry::HKEY_USERS' -ErrorAction SilentlyContinue | Where-Object {
    $_.PSChildName -match '^S-1-5-21' -or $_.PSChildName -match '^AME_UserHive_[^_]'
} | ForEach-Object {
    $sid = $_.PSChildName
    $uninstallKey = "Registry::HKEY_USERS\$sid\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\OneDriveSetup.exe"
    if (Test-Path $uninstallKey) {
        $uninstallString = (Get-ItemProperty -Path $uninstallKey -Name 'UninstallString' -ErrorAction SilentlyContinue).UninstallString
        if ($uninstallString -and $uninstallString -notmatch 'MsiExec') {
            $exePath = $uninstallString -replace '"', '' -replace '\s+/.*', ''
            if (Test-Path $exePath) { $setupPaths += $exePath }
        }
    }
    # Remove OneDrive run entry
    $runKey = "Registry::HKEY_USERS\$sid\SOFTWARE\Microsoft\Windows\CurrentVersion\Run"
    if (Test-Path $runKey) {
        Remove-ItemProperty -Path $runKey -Name 'OneDrive' -Force -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path $runKey -Name 'OneDriveSetup' -Force -ErrorAction SilentlyContinue
    }
    # Remove OneDrive uninstall entry
    if (Test-Path $uninstallKey) { Remove-Item -Path $uninstallKey -Recurse -Force }
}

# Run uninstaller on all discovered paths (with timeout)
foreach ($p in $setupPaths) {
    if (Test-Path $p) {
        Write-Host "Uninstalling OneDrive from: $p"
        $proc = Start-Process $p -ArgumentList '/uninstall' -PassThru -NoNewWindow
        if (-not $proc.WaitFor(30000)) { $proc.Kill(); Write-Host "OneDrive uninstall timed out" }
    }
}

# Remove OneDrive folders
$odFolders = @(
    "$env:LOCALAPPDATA\Microsoft\OneDrive",
    "$env:PROGRAMDATA\Microsoft OneDrive",
    "$env:SystemRoot\OneDriveTemp",
    "$env:SystemDrive\OneDriveTemp"
)
foreach ($f in $odFolders) {
    if (Test-Path $f) { Remove-Item $f -Recurse -Force }
}

# Per-user OneDrive folders - iterate all user profiles
Get-ChildItem "$env:SystemDrive\Users" -Directory -ErrorAction SilentlyContinue | ForEach-Object {
    $userOD = Join-Path $_.FullName "AppData\Local\Microsoft\OneDrive"
    $userODProfile = Join-Path $_.FullName "OneDrive"
    $userODLink = Join-Path $_.FullName "AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk"
    if (Test-Path $userOD) { Remove-Item $userOD -Recurse -Force }
    if (Test-Path $userODProfile) { Remove-Item $userODProfile -Recurse -Force }
    if (Test-Path $userODLink) { Remove-Item $userODLink -Force }
}

# Remove OneDrive registry keys
$odRegKeys = @(
    'HKCU:\Software\Microsoft\OneDrive',
    'HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive',
    'HKLM:\SOFTWARE\Microsoft\OneDrive',
    'HKCU:\Environment\OneDrive',
    'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsStore\WindowsUpdate\OneDrive'
)
foreach ($k in $odRegKeys) {
    if (Test-Path $k) { Remove-Item $k -Recurse -Force }
}

# Delete OneDriveSetup.exe and SysWOW64 copy - prevents reinstall
$odSetupPaths = @(
    "$env:SystemRoot\System32\OneDriveSetup.exe",
    "$env:SystemRoot\SysWOW64\OneDriveSetup.exe"
)
foreach ($p in $odSetupPaths) {
    if (Test-Path $p) {
        takeown.exe /F $p /A 2>$null
        icacls.exe $p /grant Administrators:F 2>$null
        Remove-Item -Path $p -Force -ErrorAction SilentlyContinue
    }
}

# Remove OneDriveSetup.exe from WinSxS
$winsxsOD = "$env:SystemRoot\WinSxS"
if (Test-Path $winsxsOD) {
    Get-ChildItem -Path $winsxsOD -Directory -Force -ErrorAction SilentlyContinue |
        Where-Object { $_.Name -like '*microsoft-windows-onedrive-setup*' } |
        ForEach-Object {
            $target = Join-Path $_.FullName 'OneDriveSetup.exe'
            if (Test-Path $target) {
                takeown.exe /F $target 2>$null | Out-Null
                icacls.exe $target /grant Administrators:F 2>$null | Out-Null
                Remove-Item -Path $target -Force -ErrorAction SilentlyContinue
            }
        }
}

# Clean OneDrive from Default user NTUSER.DAT
$ntu = 'C:\Users\Default\NTUSER.DAT'
if (Test-Path $ntu) {
    reg load 'HKLM\Atom_OD' $ntu 2>$null
    if ($LASTEXITCODE -eq 0) {
        try {
            $run = 'HKLM:\Atom_OD\Software\Microsoft\Windows\CurrentVersion\Run'
            if (Test-Path $run) {
                Remove-ItemProperty -Path $run -Name 'OneDriveSetup' -Force -ErrorAction SilentlyContinue
                Remove-ItemProperty -Path $run -Name 'OneDrive' -Force -ErrorAction SilentlyContinue
            }
            $runOnce = 'HKLM:\Atom_OD\Software\Microsoft\Windows\CurrentVersion\RunOnce'
            if (Test-Path $runOnce) {
                Remove-ItemProperty -Path $runOnce -Name 'OneDriveSetup' -Force -ErrorAction SilentlyContinue
                Remove-ItemProperty -Path $runOnce -Name 'OneDrive' -Force -ErrorAction SilentlyContinue
            }
        } catch {}
        [gc]::Collect(); Start-Sleep -Milliseconds 300
        reg unload 'HKLM\Atom_OD' 2>$null
    }
}

# Remove Default user OneDrive folder
$defaultOD = 'C:\Users\Default\AppData\Local\Microsoft\OneDrive'
if (Test-Path $defaultOD) {
    takeown.exe /F $defaultOD /R /D Y 2>$null
    icacls.exe $defaultOD /grant Administrators:F /T /C 2>$null
    Remove-Item -Path $defaultOD -Recurse -Force -ErrorAction SilentlyContinue
}
$defaultODLnk = 'C:\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk'
if (Test-Path $defaultODLnk) {
    Remove-Item -Path $defaultODLnk -Force -ErrorAction SilentlyContinue
}

# Per-user OneDrive environment + run entries
Get-ChildItem 'Registry::HKEY_USERS' -ErrorAction SilentlyContinue | Where-Object {
    $_.PSChildName -match '^S-1-5-21' -or $_.PSChildName -match '^AME_UserHive_[^_]'
} | ForEach-Object {
    $sid = $_.PSChildName
    $envKey = "Registry::HKEY_USERS\$sid\Environment"
    if (Test-Path $envKey) { Remove-ItemProperty -Path $envKey -Name 'OneDrive' -Force -ErrorAction SilentlyContinue }

    # Remove OneDrive from Explorer sidebar
    $clsid = "Registry::HKEY_USERS\$sid\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"
    if (Test-Path $clsid) { Remove-Item -Path $clsid -Recurse -Force }

    # Unpin OneDrive from Explorer
    $oneDriveCLSID = "Registry::HKEY_USERS\$sid\Software\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"
    if (Test-Path $oneDriveCLSID) {
        Set-ItemProperty -Path $oneDriveCLSID -Name 'System.IsPinnedToNameSpaceTree' -Value 0 -Type DWord -Force
    }
}

# Unpin OneDrive from Explorer (HKLM - machine-wide)
$wow64 = 'HKLM:\SOFTWARE\WOW6432Node\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}'
if (Test-Path $wow64) {
    Set-ItemProperty -Path $wow64 -Name 'System.IsPinnedToNameSpaceTree' -Value 0 -Type DWord -Force
}
$hklmClsid = 'HKLM:\SOFTWARE\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}'
if (Test-Path $hklmClsid) {
    Set-ItemProperty -Path $hklmClsid -Name 'System.IsPinnedToNameSpaceTree' -Value 0 -Type DWord -Force
}

# Remove OneDrive from SyncRootManager
$syncRoot = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SyncRootManager'
if (Test-Path $syncRoot) {
    Get-ChildItem $syncRoot -ErrorAction SilentlyContinue | Where-Object {
        $_.Name -like '*OneDrive*'
    } | Remove-Item -Recurse -Force
}

# Remove OneDrive scheduled tasks
Get-ScheduledTask -TaskPath '*' -ErrorAction SilentlyContinue | Where-Object {
    $_.TaskName -like '*OneDrive*'
} | Unregister-ScheduledTask -Confirm:$false -ErrorAction SilentlyContinue

# Remove OneDrive AppX packages
Get-AppxPackage -Name '*OneDrive*' -AllUsers -ErrorAction SilentlyContinue | Remove-AppxPackage -AllUsers
Get-AppxPackage -Name '*Microsoft.MicrosoftSkyDrive*' -AllUsers -ErrorAction SilentlyContinue | Remove-AppxPackage -AllUsers

# Remove BannerStore OneDrive entries
$bannerStore = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\BannerStore'
if (Test-Path $bannerStore) {
    Get-ChildItem $bannerStore -ErrorAction SilentlyContinue | Where-Object {
        (Get-ItemProperty $_.PSPath -ErrorAction SilentlyContinue).'(default)' -like '*OneDrive*'
    } | Remove-Item -Recurse -Force
}

# Remove AutoplayHandlers OneDrive entries
$autoplay = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\Handlers'
if (Test-Path $autoplay) {
    Get-ChildItem $autoplay -ErrorAction SilentlyContinue | Where-Object {
        $_.Name -like '*OneDrive*'
    } | Remove-Item -Recurse -Force
}

# Remove App Paths OneDrive entries
$appPaths = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths'
if (Test-Path $appPaths) {
    Get-ChildItem $appPaths -ErrorAction SilentlyContinue | Where-Object {
        $_.Name -like '*OneDrive*'
    } | Remove-Item -Recurse -Force
}

# Remove Uninstall OneDrive entries
$uninstall = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall'
if (Test-Path $uninstall) {
    Get-ChildItem $uninstall -ErrorAction SilentlyContinue | Where-Object {
        $_.Name -like '*OneDrive*'
    } | Remove-Item -Recurse -Force
}

# Disable OneDrive via Group Policy
New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive' -Force | Out-Null
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive' -Name 'DisableFileSyncNGSC' -Value 1 -Type DWord -Force

# Disable OneDrive ContentDeliveryManager entries
Get-ChildItem 'Registry::HKEY_USERS' -ErrorAction SilentlyContinue | Where-Object {
    $_.PSChildName -match '^S-1-5-21'
} | ForEach-Object {
    $cdm = "Registry::HKEY_USERS\$($_.PSChildName)\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
    if (Test-Path $cdm) {
        Set-ItemProperty -Path $cdm -Name 'SubscribedContent-280810Enabled' -Value 0 -Type DWord -Force
        Set-ItemProperty -Path $cdm -Name 'SubscribedContent-280811Enabled' -Value 0 -Type DWord -Force
    }
}

Write-Host "OneDrive fully removed."

# ═══════════════════════════════════════════════════════════
# FULL EDGE REMOVAL (backup - in case 07-edge.yml didn't run)
# ═══════════════════════════════════════════════════════════
Write-Host "=== EDGE REMOVAL ==="

Get-Process -Name msedge -Force | Stop-Process -Force
Get-Process -Name msedgewebview2 -Force | Stop-Process -Force

$edgeSetupPaths = @(
    "$env:ProgramFiles (x86)\Microsoft\Edge\Application\*\Installer\setup.exe",
    "$env:ProgramFiles\Microsoft\Edge\Application\*\Installer\setup.exe",
    "$env:LOCALAPPDATA\Microsoft\Edge\Application\*\Installer\setup.exe"
)
foreach ($pattern in $edgeSetupPaths) {
    $setup = Get-Item $pattern | Select-Object -First 1
    if ($setup) {
        $proc = Start-Process $setup.FullName -ArgumentList '--uninstall --system-level --verbose-logging' -PassThru -NoNewWindow
        if (-not $proc.WaitFor(30000)) { $proc.Kill(); Write-Host "Edge uninstall timed out" }
    }
}

$edgeFolders = @(
    "$env:ProgramFiles (x86)\Microsoft\Edge",
    "$env:ProgramFiles\Microsoft\Edge",
    "$env:LOCALAPPDATA\Microsoft\Edge",
    "$env:LOCALAPPDATA\Microsoft\EdgeUpdate",
    "$env:LOCALAPPDATA\Microsoft\EdgeWebView"
)
foreach ($f in $edgeFolders) {
    if (Test-Path $f) { Remove-Item $f -Recurse -Force }
}

# Remove Edge Update download cache
$edgeUpdateDL = "${env:ProgramFiles(x86)}\Microsoft\EdgeUpdate\Download"
if (Test-Path $edgeUpdateDL) { Remove-Item $edgeUpdateDL -Recurse -Force }

Write-Host "Edge removed."

# ═══════════════════════════════════════════════════════════
# REMOVE CALCULATOR
# ═══════════════════════════════════════════════════════════
Write-Host "Removing Calculator..."
Get-AppxPackage -Name '*WindowsCalculator*' -AllUsers | Remove-AppxPackage -AllUsers
Get-AppxProvisionedPackage -Online | Where-Object { $_.PackageName -like '*WindowsCalculator*' } | Remove-AppxProvisionedPackage -Online

# ═══════════════════════════════════════════════════════════
# DELETE WINRE — SAFE METHOD
# ═══════════════════════════════════════════════════════════
Write-Host "=== WINRE REMOVAL ==="

& reagentc.exe /disable 2>$null
& bcdedit.exe /set '{default}' recoveryenabled No 2>$null
& bcdedit.exe /set '{current}' recoveryenabled No 2>$null

$winreAgent = Join-Path $env:SystemDrive '$WinREAgent'
if (Test-Path $winreAgent) { Remove-Item -Path $winreAgent -Recurse -Force }

$winreWim = "$env:SystemRoot\System32\Recovery\Winre.wim"
if (Test-Path $winreWim) {
    & takeown.exe /F $winreWim /A 2>$null
    & icacls.exe $winreWim /grant Administrators:F 2>$null
    Remove-Item $winreWim -Force
}

Write-Host "WinRE removed."

# ═══════════════════════════════════════════════════════════
# DISABLE PAGING FILES (safe method)
# ═══════════════════════════════════════════════════════════
Write-Host "=== PAGING FILES ==="

$memMgmt = 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management'

# Remove all configured paging files
Set-ItemProperty -Path $memMgmt -Name 'PagingFiles' -Value @() -Type MultiString -Force

# Keep DisablePagingExecutive=1 (already set in 05-performance.yml)
Write-Host "Paging files disabled."

# ═══════════════════════════════════════════════════════════
# DISABLE HIBERNATION (removes hiberfil.sys — saves RAM-sized file)
# ═══════════════════════════════════════════════════════════
Write-Host "=== HIBERNATION ==="
& powercfg.exe /h off 2>$null

# Disable via registry too
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Power' -Name 'HibernateEnabledDefault' -Value 0 -Type DWord -Force
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Power' -Name 'HiberbootEnabled' -Value 0 -Type DWord -Force

Write-Host "Hibernation disabled."

# ═══════════════════════════════════════════════════════════
# DISABLE RESERVED STORAGE — DISM method
# ═══════════════════════════════════════════════════════════
Write-Host "=== RESERVED STORAGE ==="

# Primary: DISM method — most reliable
& DISM.exe /Online /Set-ReservedStorageState /State:Disabled 2>$null

# Fallback: Registry method
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\ReserveManager' -Name 'ShippedWithReserves' -Value 0 -Type DWord -Force
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\ReserveManager' -Name 'ShippedWithReserves' -Value 0 -Type DWord -Force

Write-Host "Reserved storage disabled."

# ═══════════════════════════════════════════════════════════
# DISK CLEANUP — CleanMgr Preset
# ═══════════════════════════════════════════════════════════
Write-Host "=== DISK CLEANUP ==="

$volumeCache = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches'

$cacheItems = @{
    'Active Setup Temp Folders'              = 2
    'BranchCache'                            = 2
    'Delivery Optimization Files'            = 2
    'Device Driver Packages'                 = 2
    'Diagnostic Data Viewer database files'  = 2
    'Downloaded Program Files'               = 2
    'Internet Cache Files'                   = 2
    'Language Pack'                          = 2
    'Offline Pages Files'                    = 2
    'Old ChkDsk Files'                       = 2
    'RetailDemo Offline Content'             = 2
    'Setup Log Files'                        = 2
    'System error memory dump files'         = 2
    'System error minidump files'            = 2
    'Temporary Files'                        = 2
    'Thumbnail Cache'                        = 2
    'Update Cleanup'                         = 2
    'Upgrade Discarded Files'                = 2
    'User file versions'                     = 2
    'Windows Defender'                       = 2
    'Windows Error Reporting Files'          = 2
    'Windows Reset Log Files'                = 2
    'Windows Upgrade Log Files'              = 2
}

foreach ($item in $cacheItems.GetEnumerator()) {
    $keyPath = Join-Path $volumeCache $item.Key
    if (Test-Path $keyPath) {
        New-ItemProperty -Path $keyPath -Name 'StateFlags0099' -Value $item.Value -PropertyType DWord -Force | Out-Null
    }
}

# Stop services before cleanup
Stop-Service -Name 'bits' -Force -ErrorAction SilentlyContinue
Stop-Service -Name 'appidsvc' -Force -ErrorAction SilentlyContinue
Stop-Service -Name 'dps' -Force -ErrorAction SilentlyContinue
Stop-Service -Name 'wuauserv' -Force -ErrorAction SilentlyContinue

# Run CleanMgr (with 60s timeout — don't block forever)
$cleanmgr = Start-Process -FilePath "$env:SystemRoot\system32\cleanmgr.exe" -ArgumentList '/sagerun:99' -PassThru -ErrorAction SilentlyContinue
if ($cleanmgr) {
    if (-not $cleanmgr.WaitFor(60000)) { $cleanmgr.Kill(); Write-Host "CleanMgr timed out" }
}

# Restart services
Start-Service -Name 'bits' -ErrorAction SilentlyContinue
Start-Service -Name 'wuauserv' -ErrorAction SilentlyContinue

# Trigger built-in SilentCleanup task
Start-ScheduledTask -TaskPath '\Microsoft\Windows\DiskCleanup\' -TaskName 'SilentCleanup' -ErrorAction SilentlyContinue

Write-Host "CleanMgr completed."

# ═══════════════════════════════════════════════════════════
# CLEAR ALL EVENT LOGS — with timeout
# ═══════════════════════════════════════════════════════════
Write-Host "Clearing event logs..."
$logs = wevtutil.exe l 2>$null
$logCount = 0
foreach ($log in $logs) {
    $logName = $log.Trim()
    if ($logName) {
        wevtutil.exe cl "$logName" 2>$null
        $logCount++
        if ($logCount -ge 100) { break }  # Safety limit — don't spend forever
    }
}

# Disable SleepStudy logging
& wevtutil.exe set-log 'Microsoft-Windows-SleepStudy/Diagnostic' /e:false 2>$null
& wevtutil.exe set-log 'Microsoft-Windows-Kernel-Processor-Power/Diagnostic' /e:false 2>$null
& wevtutil.exe set-log 'Microsoft-Windows-UserModePowerService/Diagnostic' /e:false 2>$null

# ═══════════════════════════════════════════════════════════
# DELETE SYSTEM RESTORE POINTS — with timeout
# ═══════════════════════════════════════════════════════════
Write-Host "Deleting system restore points..."
$vss = Start-Process -FilePath 'vssadmin.exe' -ArgumentList 'delete shadows /all /quiet' -PassThru -NoNewWindow -ErrorAction SilentlyContinue
if ($vss) {
    if (-not $vss.WaitFor(30000)) { $vss.Kill(); Write-Host "vssadmin timed out" }
}

# Disable System Restore
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore' -Name 'RPSessionInterval' -Value 0 -Type DWord -Force
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore\cfg' -Name 'DiskPercent' -Value 0 -Type DWord -Force

# ═══════════════════════════════════════════════════════════
# DELETE SYSTEM FOLDERS — 11 system folders
# ═══════════════════════════════════════════════════════════
Write-Host "Cleaning system folders..."

$sysFolders = @(
    'CbsTemp',
    'Logs',
    'SoftwareDistribution',
    'System32\LogFiles',
    'System32\LogFiles\WMI',
    'System32\SleepStudy',
    'System32\sru',
    'System32\WDI\LogFiles',
    'System32\winevt\Logs',
    'SystemTemp',
    'Temp'
)
foreach ($folder in $sysFolders) {
    $folderPath = Join-Path $env:SystemRoot $folder
    if (Test-Path $folderPath) {
        Get-ChildItem -Path $folderPath -ErrorAction SilentlyContinue | 
            Select-Object -First 500 | 
            Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
    }
}

# ═══════════════════════════════════════════════════════════
# DELETE TEMPORARY FILES
# ═══════════════════════════════════════════════════════════
Write-Host "Cleaning temp files..."

# User temp (exclude AME folder)
Get-ChildItem -Path "$env:TEMP" -Exclude 'AME', 'Revision-Tool' -ErrorAction SilentlyContinue | 
    Select-Object -First 1000 | 
    Remove-Item -Recurse -Force -ErrorAction SilentlyContinue

# System temp
$sysTemp = "$env:SystemRoot\Temp"
if (Test-Path $sysTemp) { Remove-Item -Path "$sysTemp\*" -Force -Recurse }

# Windows.old and upgrade folders
$cleanupPaths = @(
    "$env:SystemRoot\Windows.old",
    "$env:SystemRoot\$Windows.~BT",
    "$env:SystemRoot\$Windows.~WS",
    "$env:SystemRoot\SoftwareDistribution\Download",
    "$env:SystemRoot\Logs\CBS",
    "$env:SystemRoot\Logs\DISM",
    "$env:SystemRoot\Logs\MoSetup",
    "$env:SystemRoot\Installer\$PatchCache$"
)
foreach ($p in $cleanupPaths) {
    if (Test-Path $p) { Remove-Item $p -Recurse -Force -ErrorAction SilentlyContinue }
}

# Delete Windows Update cache
Stop-Service -Name 'wuauserv' -Force -ErrorAction SilentlyContinue
Remove-Item "$env:SystemRoot\SoftwareDistribution\Download\*" -Recurse -Force -ErrorAction SilentlyContinue
Start-Service -Name 'wuauserv' -ErrorAction SilentlyContinue

# ═══════════════════════════════════════════════════════════
# WINSXS COMPONENT CLEANUP
# ═══════════════════════════════════════════════════════════
Write-Host "Cleaning WinSxS component store..."

# Basic cleanup (safe — no ResetBase, with 5min timeout)
$dism = Start-Process -FilePath 'DISM.exe' -ArgumentList '/Online /Cleanup-Image /StartComponentCleanup' -PassThru -NoNewWindow -ErrorAction SilentlyContinue
if ($dism) {
    if (-not $dism.WaitFor(300000)) { $dism.Kill(); Write-Host "DISM StartComponentCleanup timed out" }
}

# Full cleanup with ResetBase (only when -FullWinSxS flag is set, with 10min timeout)
if ($FullWinSxS) {
    Write-Host "Running full WinSxS cleanup with ResetBase..."
    $dismFull = Start-Process -FilePath 'DISM.exe' -ArgumentList '/Online /Cleanup-Image /StartComponentCleanup /ResetBase' -PassThru -NoNewWindow -ErrorAction SilentlyContinue
    if ($dismFull) {
        if (-not $dismFull.WaitFor(600000)) { $dismFull.Kill(); Write-Host "DISM ResetBase timed out" }
    }
    Write-Host "Full WinSxS cleanup completed."
}

# ═══════════════════════════════════════════════════════════
# NTFS OPTIMIZATION — registry, not fsutil
# ═══════════════════════════════════════════════════════════
Write-Host "Optimizing NTFS..."

# Disable last access time stamp (registry method — more reliable than fsutil)
$ntfsKey = 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem'
Set-ItemProperty -Path $ntfsKey -Name 'NtfsDisableLastAccessUpdate' -Value 1 -Type DWord -Force
Set-ItemProperty -Path $ntfsKey -Name 'NtfsAllowExtendedCharacterIn8dot3Name' -Value 0 -Type DWord -Force
Set-ItemProperty -Path $ntfsKey -Name 'NtfsDisable8dot3NameCreation' -Value 1 -Type DWord -Force

# ═══════════════════════════════════════════════════════════
# DISABLE LOGGING
# ═══════════════════════════════════════════════════════════
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System' -Name 'RSoPLogging' -Value 0 -Type DWord -Force

Write-Host "=== CLEANUP COMPLETE ==="
