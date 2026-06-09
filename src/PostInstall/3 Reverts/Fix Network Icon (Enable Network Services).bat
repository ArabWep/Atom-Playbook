sc config NetSetupSvc start= demand
sc config Netman start= demand
sc config netprofm start= demand
sc config NlaSvc start= auto
sc config NcbService start= demand
sc start Netman
sc start netprofm
sc start NlaSvc
sc start NetSetupSvc
sc start NcbService