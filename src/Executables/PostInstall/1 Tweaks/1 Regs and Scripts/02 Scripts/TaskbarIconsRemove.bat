@echo off

:: Disable Windows Search icon on taskbar
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSearch /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable Task View icon on taskbar
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTaskViewButton /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable News and Interests / Widgets on taskbar
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Feeds" /v ShellFeedsTaskbarViewMode /t REG_DWORD /d 0 /f >nul 2>&1

:: Restart Explorer to apply changes
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

exit
