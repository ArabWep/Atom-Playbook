@echo off
:: Disable Reserved Storage via DISM
dism /Online /Set-ReservedStorageState /State:Disabled >nul 2>&1
:: Ensure policy-based disable (extra hardening)
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ReserveManager" ^
/v ShippedWithReserves /t REG_DWORD /d 0 /f >nul 2>&1
:: Prevent future re-enablement
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\ReserveManager" ^
/v ShippedWithReserves /t REG_DWORD /d 0 /f >nul 2>&1
exit /b
