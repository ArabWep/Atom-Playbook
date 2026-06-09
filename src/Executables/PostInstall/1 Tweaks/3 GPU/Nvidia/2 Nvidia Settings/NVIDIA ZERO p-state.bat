@echo off

:: Set NVIDIA P-State / Max Performance (Registry tweak)
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\PowerManagement" /v PerfLevelSrc /t REG_DWORD /d 0 /f >nul 2>&1
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\PowerManagement" /v PerfLevelDest /t REG_DWORD /d 0 /f >nul 2>&1

:: Optional: Force Max GPU Performance in Power Plan
powercfg -setacvalueindex SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMIN 100 >nul 2>&1
powercfg -setacvalueindex SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMAX 100 >nul 2>&1
powercfg -setactive SCHEME_CURRENT >nul 2>&1

exit
