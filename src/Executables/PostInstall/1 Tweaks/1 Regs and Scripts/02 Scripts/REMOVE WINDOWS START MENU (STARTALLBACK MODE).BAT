@echo off
title REMOVE WINDOWS START MENU (STARTALLBACK MODE)
color 0C

:: ADMIN CHECK
net session >nul 2>&1 || (
    echo RUN AS ADMIN
    pause
    exit /b
)

echo ==========================================
echo   REMOVING WINDOWS START MENU COMPLETELY
echo ==========================================
echo.
pause

:: =================================================
:: 1. KILL START MENU PROCESSES
:: =================================================
echo [*] Killing Start Menu processes...
taskkill /f /im StartMenuExperienceHost.exe >nul 2>&1
taskkill /f /im SearchHost.exe >nul 2>&1
taskkill /f /im SearchApp.exe >nul 2>&1

:: =================================================
:: 2. BLOCK START MENU FROM RELAUNCHING
:: =================================================
echo [*] Blocking Start Menu packages...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\Deprovisioned" ^
 /v Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy ^
 /t REG_SZ /d 1 /f

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\Deprovisioned" ^
 /v Microsoft.Windows.Search_cw5n1h2txyewy ^
 /t REG_SZ /d 1 /f

:: =================================================
:: 3. DISABLE START MENU SERVICES
:: =================================================
echo [*] Disabling related services...
sc stop WSearch >nul 2>&1
sc config WSearch start= disabled >nul 2>&1

:: =================================================
:: 4. DISABLE START MENU TASKS
:: =================================================
echo [*] Disabling Start scheduled tasks...
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyMonitor" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyRefresh" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyUpload" /disable >nul 2>&1

schtasks /change /tn "\Microsoft\Windows\Search\SearchIndexer" /disable >nul 2>&1

:: =================================================
:: 5. FORCE CLASSIC EXPLORER BEHAVIOR
:: =================================================
echo [*] Forcing classic Explorer shell behavior...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" ^
 /v Start_ShowClassicMode /t REG_DWORD /d 1 /f

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" ^
 /v SearchboxTaskbarMode /t REG_DWORD /d 0 /f

:: =================================================
:: 6. PREVENT SEARCH UI FROM COMING BACK
:: =================================================
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" ^
 /v BingSearchEnabled /t REG_DWORD /d 0 /f

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" ^
 /v CortanaConsent /t REG_DWORD /d 0 /f

:: =================================================
:: 7. RESTART EXPLORER
:: =================================================
echo [*] Restarting Explorer...
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

echo.
echo ==========================================
echo   WINDOWS START MENU REMOVED
echo   STARTALLBACK IS NOW PRIMARY
echo ==========================================
pause
exit
