@echo off
:: Set wallpaper silently
REG ADD "HKCU\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "C:\Windows\Web\Wallpaper\Windows\img0.jpg" /f >nul 2>&1

:: Apply the wallpaper immediately
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters ,1 ,True

exit
