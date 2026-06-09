@echo off
:: ============================================
:: Disable Windows Hibernation (Silent & Advanced)
:: ============================================

:: Require admin
net session >nul 2>&1
if %errorlevel% neq 0 exit /b

:: Disable hibernation file (hiberfil.sys)
powercfg -h off >nul 2>&1

:: Disable Fast Startup
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" ^
/v HiberbootEnabled /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable Hibernate option in power menu
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" ^
/v ShowHibernateOption /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable Hybrid Sleep (AC & DC)
powercfg -setacvalueindex SCHEME_CURRENT SUB_SLEEP HYBRIDSLEEP 0 >nul 2>&1
powercfg -setdcvalueindex SCHEME_CURRENT SUB_SLEEP HYBRIDSLEEP 0 >nul 2>&1

:: Disable Hibernate timeout
powercfg -setacvalueindex SCHEME_CURRENT SUB_SLEEP HIBERNATEIDLE 0 >nul 2>&1
powercfg -setdcvalueindex SCHEME_CURRENT SUB_SLEEP HIBERNATEIDLE 0 >nul 2>&1

:: Apply power scheme
powercfg -setactive SCHEME_CURRENT >nul 2>&1

exit /b
