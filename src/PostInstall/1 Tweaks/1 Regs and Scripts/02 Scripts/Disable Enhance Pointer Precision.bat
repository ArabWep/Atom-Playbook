REG ADD "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 0 /f >nul 2>&1
REG ADD "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d 0 /f >nul 2>&1
REG ADD "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d 0 /f >nul 2>&1
REG ADD "HKCU\Control Panel\Mouse" /v MouseSensitivity /t REG_SZ /d 10 /f >nul 2>&1
exit
