@echo off
setlocal

:: Get total RAM in GB (integer)
for /f "tokens=2 delims==" %%A in ('wmic computersystem get TotalPhysicalMemory /value ^| find "="') do set RAMBYTES=%%A
set /a RAMGB=%RAMBYTES%/1024/1024/1024

:: Default value
set VALUE=400000

:: Set according to table
if %RAMGB% GEQ 6  set VALUE=600000
if %RAMGB% GEQ 8  set VALUE=800000
if %RAMGB% GEQ 12 set VALUE=C00000
if %RAMGB% GEQ 16 set VALUE=1000000
if %RAMGB% GEQ 24 set VALUE=1800000
if %RAMGB% GEQ 32 set VALUE=2000000
if %RAMGB% GEQ 64 set VALUE=4000000

:: Apply to Registry silently
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control" /v SvcHostSplitThresholdInKB /t REG_DWORD /d %VALUE% /f >nul 2>&1

endlocal
exit
