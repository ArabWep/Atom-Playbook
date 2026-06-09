@echo off
title SVC Host Advanced RAM Optimizer
color 0A

:: Admin Check
net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo Run as Administrator!
    pause
    exit
)

:menu
cls
echo =============================================
echo        SVC Host Advanced RAM Optimizer
echo =============================================
echo.
echo 1 - 4GB RAM
echo 2 - 8GB RAM
echo 3 - 16GB RAM
echo 4 - 32GB RAM
echo 5 - Ultra Low RAM Mode (Lowest Possible)
echo 6 - Custom Value
echo 7 - RESET (Windows Default)
echo 8 - Exit
echo.
set /p choice=Choose option: 

if "%choice%"=="1" set value=4194304
if "%choice%"=="2" set value=8388608
if "%choice%"=="3" set value=16777216
if "%choice%"=="4" set value=33554432
if "%choice%"=="5" set value=380000

if "%choice%"=="6" goto custom
if "%choice%"=="7" goto reset
if "%choice%"=="8" exit

if defined value goto apply
goto menu

:custom
cls
echo Enter value in KB:
set /p value=Value: 
goto apply

:reset
cls
echo Restoring Windows Default Behavior...
reg delete "HKLM\SYSTEM\CurrentControlSet\Control" /v SvcHostSplitThresholdInKB /f
echo.
echo Reset Complete!
echo Restart required.
pause
exit

:apply
cls
echo Creating Backup...
reg export "HKLM\SYSTEM\CurrentControlSet\Control" "%~dp0SvcHost_Backup.reg" /y

echo.
echo Applying value %value% ...
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v SvcHostSplitThresholdInKB /t REG_DWORD /d %value% /f

echo.
echo Done!
echo Restart your PC for full effect.
pause
exit
