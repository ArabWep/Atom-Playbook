@echo off
title Disable Paging File - Advanced Warning

echo ===============================================
echo   WARNING: DISABLING THE WINDOWS PAGING FILE
echo ===============================================
echo.
echo - May cause system instability
echo - Can lead to crashes or BSODs on low RAM systems
echo - NOT recommended for systems with less than 16GB RAM
echo - Changes require a SYSTEM RESTART
echo.
echo This tweak is intended for advanced users only.
echo.
choice /c YN /n /m "Do you want to continue? (Y/N): "

if errorlevel 2 (
    echo.
    echo Operation cancelled by user.
    timeout /t 2 >nul
    exit /b
)

echo.
echo Disabling paging file...

:: Disable automatic page file management
wmic computersystem where name="%computername%" set AutomaticManagedPagefile=False >nul 2>&1

:: Remove existing page file
wmic pagefileset where name="C:\\pagefile.sys" delete >nul 2>&1

:: Extra registry hardening
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" ^
/v PagingFiles /t REG_MULTI_SZ /d "" /f >nul 2>&1

echo.
echo Paging file has been disabled.
echo A system restart is REQUIRED for changes to take effect.
echo.

pause
exit /b
