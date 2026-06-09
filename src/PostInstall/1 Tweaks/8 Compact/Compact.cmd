@echo off
%SystemDrive%
::BatchGotAdmin, Partially created by Ankh Tech=======================================================
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (powershell start -verb runas '%0' am_admin & exit)
::====================================================================================================
compact /c /s /i /a /exe:LZX "%SystemDrive%\Windows\*"
compact /c /s /i /a /exe:LZX "%SystemDrive%\Program Files\*"
compact /c /s /i /a /exe:LZX "%SystemDrive%\Program Files (x86)\*"
compact /c /s /i /a /exe:LZX "C:\ProgramData\*"
exit