@echo off
bcdedit /set hypervisorlaunchtype off
powershell -Command "Disable-MMAgent -PageCombining"
powercfg /setactive SCHEME_MIN
bcdedit /set disabledynamictick yes
bcdedit /set useplatformtick yes
bcdedit /set tscsyncpolicy Enhanced
bcdedit /set {current} forcefipscrypto no
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v EnableUlps /t REG_DWORD /d 0 /f
exit
