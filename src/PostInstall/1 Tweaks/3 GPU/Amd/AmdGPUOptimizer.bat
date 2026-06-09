@echo off

:: Kill AMD Radeon background tasks
taskkill /F /IM "AMDRSServ.exe" >nul 2>&1
taskkill /F /IM "AMDRSSrcExt.exe" >nul 2>&1
taskkill /F /IM "AMDRSSrcExtHelper.exe" >nul 2>&1
taskkill /F /IM "RadeonSoftware.exe" >nul 2>&1
taskkill /F /IM "AMDRSSrcSrv.exe" >nul 2>&1

:: Disable AMD Telemetry tasks
schtasks /Change /TN "AMD\AMD Updater" /Disable >nul 2>&1
schtasks /Change /TN "AMD\AMDRSSr" /Disable >nul 2>&1

:: Disable AMD crash reporting service
sc stop "AMD External Events Utility" >nul 2>&1
sc config "AMD External Events Utility" start= disabled >nul 2>&1

:: Disable ULPS (Ultra Low Power State)
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v EnableUlps /t REG_DWORD /d 0 /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0001" /v EnableUlps /t REG_DWORD /d 0 /f

:: Force max GPU power mode (Dynamic Boost = off)
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v KmdEnableDynamicBoost /t REG_DWORD /d 0 /f

:: Enable Hardware Accelerated GPU Scheduling (HAGS)
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 2 /f

:: Force GPU priority
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 38 /f

:: Set High Performance in power plans
powercfg -setacvalueindex SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMIN 100
powercfg -setacvalueindex SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMAX 100
powercfg -setacvalueindex SCHEME_CURRENT SUB_GRAPHICS GPUBOOST 100
powercfg -setactive SCHEME_CURRENT

exit
