REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v BingSearchEnabled /t REG_DWORD /d 0 /f >nul 2>&1
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v CortanaConsent /t REG_DWORD /d 0 /f >nul 2>&1
exit
