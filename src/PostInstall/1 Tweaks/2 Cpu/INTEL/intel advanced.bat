@echo off
:: High Performance Plan
powercfg -setactive SCHEME_MIN

:: Disable CPU idle states
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "Attributes" /t REG_DWORD /d 0 /f
powercfg -setacvalueindex SCHEME_MIN SUB_PROCESSOR CPMINCORES 100
powercfg -setacvalueindex SCHEME_MIN SUB_PROCESSOR CPMAXCORES 100
powercfg -setacvalueindex SCHEME_MIN SUB_PROCESSOR MAXPROCSTATE 100
powercfg -setacvalueindex SCHEME_MIN SUB_PROCESSOR MINPROCSTATE 100
powercfg -setacvalueindex SCHEME_MIN SUB_PROCESSOR PARKINGMAXCORES 100
powercfg -setacvalueindex SCHEME_MIN SUB_PROCESSOR PARKINGMINCORES 100
powercfg -setactive SCHEME_MIN

:: Disable unnecessary services
sc config "SysMain" start= disabled
sc stop "SysMain"

:: Disable hibernation
powercfg -h off

:: Disable Game DVR
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f

:: Remove telemetry
schtasks /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable
schtasks /Change /TN "Microsoft\Windows\Autochk\Proxy" /Disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable


exit /b 0
