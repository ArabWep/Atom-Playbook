@echo off
REM Set file association
assoc .pow=PowerPlanFile

REM Define how .pow files are handled
reg add "HKEY_CLASSES_ROOT\PowerPlanFile\shell\open\command" /ve /d "\"%SystemRoot%\System32\cmd.exe\" /c powercfg -import \"%%1\"" /f
