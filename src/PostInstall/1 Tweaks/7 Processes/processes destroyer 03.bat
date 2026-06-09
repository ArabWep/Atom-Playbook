@echo off
set services="diagnosticshub.standardcollector.service" "DiagTrack" "dmwappushservice" "lfsvc" "MapsBroker" "NetTcpPortSharing" "RemoteAccess" "RemoteRegistry" "SharedAccess" "TrkWks" "WbioSrvc" "ndu" "WerSvc" "Spooler" "Fax" "fhsvc" "gupdate" "gupdatem" "stisvc" "AJRouter" "MSDTC" "WpcMonSvc" "PhoneSvc" "PcaSvc" "WPDBusEnum" "seclogon" "lmhosts" "wisvc" "FontCache" "RetailDemo" "ALG" "SCardSvr" "SCPolicySvc" "ScDeviceEnum" "MessagingService_34048" "EntAppSvc" "Browser" "BDESVC" "iphlpsvc" "edgeupdate" "MicrosoftEdgeElevationService" "edgeupdatem" "SEMgrSvc" "PerfHost" "BcastDVRUserService_48486de" "WpnService" "DoSvc" "SNMPTrap" "SECOMNService" "autotimesvc" "tzautoupdate" "BcastDVRUserService_34048" "PenService_34048" "tapisrv" "HvHost" "vmickvpexchange" "vmicguestinterface" "vmicshutdown" "vmicheartbeat" "vmicvmsession" "vmicrdv" "vmictimesync"
for %%s in (%services%) do (
    sc config "%%s" start= disabled >nul 2>&1
    echo Disabling service %%s
)
sc stop "DiagTrack" >nul 2>&1
sc config "DiagTrack" start= disabled >nul 2>&1

sc stop "SysMain" >nul 2>&1
sc config "SysMain" start= disabled >nul 2>&1

sc stop "WSearch" >nul 2>&1
sc config "WSearch" start= disabled >nul 2>&1

sc stop "XboxGipSvc" >nul 2>&1
sc config "XboxGipSvc" start= disabled >nul 2>&1

sc stop "XblAuthManager" >nul 2>&1
sc config "XblAuthManager" start= disabled >nul 2>&1

sc stop "XblGameSave" >nul 2>&1
sc config "XblGameSave" start= disabled >nul 2>&1

sc stop "XboxNetApiSvc" >nul 2>&1
sc config "XboxNetApiSvc" start= disabled >nul 2>&1

sc stop "RetailDemo" >nul 2>&1
sc config "RetailDemo" start= disabled >nul 2>&1

sc stop "dmwappushservice" >nul 2>&1
sc config "dmwappushservice" start= disabled >nul 2>&1

sc stop "Fax" >nul 2>&1
sc config "Fax" start= disabled >nul 2>&1

sc stop "RemoteRegistry" >nul 2>&1
sc config "RemoteRegistry" start= disabled >nul 2>&1

sc stop "MapsBroker" >nul 2>&1
sc config "MapsBroker" start= disabled >nul 2>&1

sc stop "lfsvc" >nul 2>&1
sc config "lfsvc" start= disabled >nul 2>&1

sc stop "SharedAccess" >nul 2>&1
sc config "SharedAccess" start= disabled >nul 2>&1

sc stop "NetTcpPortSharing" >nul 2>&1
sc config "NetTcpPortSharing" start= disabled >nul 2>&1

sc stop "PhoneSvc" >nul 2>&1
sc config "PhoneSvc" start= disabled >nul 2>&1

sc stop "WalletService" >nul 2>&1
sc config "WalletService" start= disabled >nul 2>&1

sc stop "Spooler" >nul 2>&1
sc config "Spooler" start= disabled >nul 2>&1

sc stop "TrkWks" >nul 2>&1
sc config "TrkWks" start= disabled >nul 2>&1

sc stop "wuauserv" >nul 2>&1
sc config "wuauserv" start= disabled >nul 2>&1

sc stop "diagnosticshub.standardcollector.service" >nul 2>&1
sc config "diagnosticshub.standardcollector.service" start= disabled >nul 2>&1

taskkill /F /IM OneDrive.exe >nul 2>&1
taskkill /F /IM SearchApp.exe >nul 2>&1
taskkill /F /IM YourPhone.exe >nul 2>&1
taskkill /F /IM Widgets.exe >nul 2>&1
taskkill /F /IM GameBar.exe >nul 2>&1
taskkill /F /IM GameBarFTServer.exe >nul 2>&1
exit
