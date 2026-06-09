$ErrorActionPreference = 'Stop'

# Resolve source from playbook root (one level up from Executables)
$playbookRoot = Split-Path $PSScriptRoot -Parent
$srcExe       = Join-Path $playbookRoot 'PostInstall\AtomToolBox-1.0.0.exe'
$installDir   = 'C:\Program Files\AtomToolBox'
$dstExe       = Join-Path $installDir 'AtomToolBox-1.0.0.exe'

if (-not (Test-Path $srcExe)) {
    Write-Warning "AtomToolBox source not found: $srcExe"
    exit 1
}

# 1. Install to Program Files
New-Item -ItemType Directory -Path $installDir -Force | Out-Null
Copy-Item -Path $srcExe -Destination $dstExe -Force

# 2. Create shortcuts via WScript.Shell
$wsh = New-Object -ComObject WScript.Shell

# Desktop shortcut (GetFolderPath is robust against OneDrive relocation)
$desktopPath = [Environment]::GetFolderPath('Desktop')
$scDesktop = $wsh.CreateShortcut((Join-Path $desktopPath 'AtomToolBox.lnk'))
$scDesktop.TargetPath = $dstExe
$scDesktop.WorkingDirectory = $installDir
$scDesktop.IconLocation = $dstExe
$scDesktop.Save()

# Start Menu shortcut (All Users)
$startMenuPath = 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs'
New-Item -ItemType Directory -Path $startMenuPath -Force | Out-Null
$scStart = $wsh.CreateShortcut((Join-Path $startMenuPath 'AtomToolBox.lnk'))
$scStart.TargetPath = $dstExe
$scStart.WorkingDirectory = $installDir
$scStart.IconLocation = $dstExe
$scStart.Save()

# Taskbar Pin (Quick Launch method — picked up on next Explorer restart)
$taskbarPinPath = Join-Path $env:APPDATA 'Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar'
New-Item -ItemType Directory -Path $taskbarPinPath -Force | Out-Null
$scTaskbar = $wsh.CreateShortcut((Join-Path $taskbarPinPath 'AtomToolBox.lnk'))
$scTaskbar.TargetPath = $dstExe
$scTaskbar.WorkingDirectory = $installDir
$scTaskbar.IconLocation = $dstExe
$scTaskbar.Save()
