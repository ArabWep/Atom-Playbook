@echo off
sc stop "NvContainerLocalSystem" >nul 2>&1
sc stop "NvTelemetryContainer" >nul 2>&1
sc config "NvContainerLocalSystem" start= disabled
sc config "NvTelemetryContainer" start= disabled
schtasks /Change /TN "\NVIDIA GeForce Experience SelfUpdate" /Disable >nul 2>&1
schtasks /Change /TN "\NVIDIA Corporation\NvContainerLocalSystem" /Disable >nul 2>&1
schtasks /Change /TN "\NVIDIA Corporation\NvTelemetryContainer" /Disable >nul 2>&1
