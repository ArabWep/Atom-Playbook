@echo off

:: Kill NVIDIA background processes
taskkill /F /IM "NvBackend.exe" >nul 2>&1
taskkill /F /IM "NvContainer.exe" >nul 2>&1
taskkill /F /IM "NvTelemetryContainer.exe" >nul 2>&1
taskkill /F /IM "NVIDIA Web Helper.exe" >nul 2>&1
taskkill /F /IM "NVIDIA Share.exe" >nul 2>&1
taskkill /F /IM "NVIDIA GeForce Experience.exe" >nul 2>&1
taskkill /F /IM "nvsphelper64.exe" >nul 2>&1

:: Stop NVIDIA Telemetry services
sc stop NvTelemetryContainer >nul 2>&1
sc config NvTelemetryContainer start= disabled >nul 2>&1

:: Stop other unnecessary NVIDIA services
sc stop NvContainerLocalSystem >nul 2>&1
sc config NvContainerLocalSystem start= disabled >nul 2>&1

sc stop NvContainerNetworkService >nul 2>&1
sc config NvContainerNetworkService start= disabled >nul 2>&1

:: Disable NVIDIA scheduled tasks (telemetry, updates)
schtasks /Change /TN "NvTmRep_CrashReport1" /Disable >nul 2>&1
schtasks /Change /TN "NvTmRep_CrashReport2" /Disable >nul 2>&1
schtasks /Change /TN "NvTmRep_CrashReport3" /Disable >nul 2>&1
schtasks /Change /TN "NvTmRep_CrashReport4" /Disable >nul 2>&1

:: Force Hardware-Accelerated GPU Scheduling (HAGS)
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 2 /f

:: Force max GPU performance in Windows power plan
powercfg -setacvalueindex SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMIN 100
powercfg -setacvalueindex SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMAX 100
powercfg -setactive SCHEME_CURRENT

:: Force GPU driver to prefer maximum performance
REG ADD "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" /v EnableRID69527 /t REG_DWORD /d 1 /f

exit
