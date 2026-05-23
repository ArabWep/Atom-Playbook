# Atom Playbook

**Windows customization playbook for advanced users, built on the AME Wizard framework.**

[![Version](https://img.shields.io/badge/version-0.4-blue.svg)](https://github.com/projectatom1/Atom-Playbook/releases)
[![Windows](https://img.shields.io/badge/Windows-10%20%7C%2011-0078D6?logo=windows)](https://github.com/projectatom1/Atom-Playbook)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![AME Wizard](https://img.shields.io/badge/AME%20Wizard-Compatible-orange.svg)](https://ameliorated.io)

[Download](https://github.com/projectatom1/Atom-Playbook/releases) • [Documentation](https://www.atom-os.com/docs) • [Website](https://www.atom-os.com/) • [Report Bug](info@atom-os.com)

---

## Important Notice

This project is intended for **educational and research purposes**. It demonstrates Windows customization techniques using the AME Wizard framework. Users must understand the implications of system modifications and use this software responsibly.

**Not recommended for:**
- Production or work environments
- Users unfamiliar with Windows internals
- Systems requiring specific security compliance

**Always:**
- Create a full system backup before use
- Test in a virtual machine first
- Review all changes before applying
- Understand what each option does

---

## Overview

**Atom Playbook** is an advanced Windows customization playbook designed for the [AME Wizard](https://ameliorated.io) framework. It provides power users with granular control over their Windows installation, enabling deep personalization and optimization.

### Key Features
- **Deep customization** – Modify Windows behavior and appearance
- **Granular control** – Choose exactly which changes to apply
- **Performance tuning** – Optimize system resources
- **Privacy options** – Configure telemetry and tracking settings
- **Custom theming** – Apply the exclusive Atom visual theme
- **Fully documented** – All changes are transparent and logged

---

## Features

### Visual Customization
- Custom Atom theme with wallpaper and color scheme
- Streamlined taskbar and Start Menu
- Enhanced File Explorer settings
- Removal of pre-installed apps and bloatware

### System Optimization
- Removal of unnecessary UWP apps (40+ applications)
- Configuration of Windows services
- Storage optimization
- Reduction of background processes
- Boot performance improvements

### Privacy Configuration
- Telemetry settings control
- Web search integration options
- Advertising preferences
- Location and tracking settings
- Cloud sync configuration

### Application Management
- Browser selection (Brave, Zen, Chrome)
- Legacy Internet Explorer removal
- OneDrive configuration with data preservation
- Custom application preferences

### Advanced Options
Users may optionally configure:
- System security settings
- Windows Update behavior
- Default browser preferences
- System component management

> Advanced options should only be used by experienced users who understand their implications.

---

## System Requirements

### Supported Windows Versions

| Version | Build | Status |
|---------|-------|--------|
| Windows 10 1909 | 18363 | Supported |
| Windows 10 2004 | 19041 | Supported |
| Windows 10 20H2 | 19042 | Supported |
| Windows 10 21H1 | 19043 | Supported |
| Windows 10 21H2 | 19044 | Supported |
| Windows 10 22H2 | 19045 | Supported |
| Windows 11 21H2 | 22000 | Supported |
| Windows 11 22H2 | 22621 | Supported |
| Windows 11 23H2 | 22631 | Supported |
| Windows 11 24H2 | 22635 | Supported |
| Windows 11 Insider | 26100+ | Supported |

### Prerequisites
- Internet connection
- No pending Windows updates
- Device plugged into power
- [AME Wizard](https://ameliorated.io) installed
- System backup created
- Understanding of Windows system administration

---

## Installation

### Pre-Installation Checklist

Before proceeding, ensure you have:

1. Created a full system backup or restore point
2. Saved all important work
3. Tested in a virtual machine (recommended)
4. Read and understood all options
5. Accepted the risks of system modification

### Step 1: Download AME Wizard
1. Visit [ameliorated.io](https://ameliorated.io)
2. Download the latest AME Wizard
3. Extract and run `AME Wizard.exe`

### Step 2: Download Atom Playbook
1. Go to [Releases](https://github.com/projectatom1/Atom-Playbook/releases)
2. Download `AtomPlaybook_0.1.apbx`
3. Verify file integrity (checksums provided in release)

### Step 3: Run the Playbook
1. Open **AME Wizard**
2. Drag and drop `AtomPlaybook_0.1.apbx` into AME Wizard
3. Carefully review all available options
4. Select your preferences:
   - Browser (Brave, Zen, Chrome, or None)
   - Theme (Default or Atom Theme)
   - Advanced options (if applicable)
5. Click **Run** and wait for completion
6. Restart your computer when prompted

---

## What Gets Modified?

### Removed Components (Optional)
- Internet Explorer (legacy browser)
- OneDrive integration (with data preservation)
- Pre-installed UWP applications
- Web search integration in Start Menu
- Telemetry scheduled tasks

### Modified Settings
- Privacy and telemetry configurations
- File Explorer display options
- Taskbar appearance
- Start Menu recommendations
- Search behavior (local-focused)
- Visual effects and performance

### Added Features
- Atom custom theme (optional)
- Browser of choice installation
- Optimized visual settings
- Enhanced user interface

---

## Disabled Features

The following Windows features are disabled by the playbook (unless opted out):

<details>
<summary>Click to expand the complete list</summary>

- Windows Update
- Telemetry & CEIP
- Windows Search
- Print Spooler
- Fax
- File History
- Windows Error Reporting
- Remote Desktop (as server)
- Remote Registry
- Connected Devices Platform
- Delivery Optimization
- Bluetooth
- Wi-Fi Direct
- Device Management Enrollment
- Certificate Propagation
- Smart Card
- Parental Controls
- Geolocation
- Sensors
- Tablet & Pen Input
- Touch Keyboard
- Windows Connect Now (WCN)
- SSDP Discovery / UPnP
- Windows Image Acquisition (WIA)
- Windows Media Player Network Sharing
- Cortana
- Windows Spotlight
- Live Tiles
- Toast Notifications
- Xbox Accessory Management
- Microsoft Edge Update
- Google Chrome Background Updates
- Microsoft Store automatic downloads
- OneDrive (auto-sync, if killed)
- GameDVR & Game Bar (if killed)
- Widgets (if killed)
- Your Phone (if killed)
- Windows Insider Program
- Phone Service
- WalletService
- NFC Service

</details>

---

## Disabled Services

The following Windows services are disabled by the playbook:

<details>
<summary>Click to expand the complete list</summary>

| Service Name | Description |
|--------------|-------------|
| AeLookupSvc | Application Experience – telemetry and compatibility checks |
| ALG | Application Layer Gateway Service – legacy firewall component |
| AppIDSvc | Application Identity – used for AppLocker |
| AppMgmt | Application Management – group policy software installation |
| AppReadiness | App Readiness – prepares apps on first login |
| AutoTimeUpdater | Auto Time Zone Updater |
| BITS | Background Intelligent Transfer Service |
| Browser | Computer Browser (deprecated) |
| BTAGService | Bluetooth Audio Gateway Service |
| bthserv | Bluetooth Support Service |
| CDPSvc | Connected Devices Platform Service |
| CDPUserSvc | Connected Devices Platform User Service |
| DiagTrack | Connected User Experiences and Telemetry |
| DispBrokerDesktopSvc | Display Policy Service |
| DPS | Diagnostic Policy Service |
| WdiServiceHost | Diagnostic Service Host |
| WdiSystemHost | Diagnostic System Host |
| DmEnrollmentSvc | Device Management Enrollment Service |
| dmwappushservice | Device Management WAP Push |
| DoSvc | Delivery Optimization |
| EFS | Encrypting File System |
| Fax | Fax Service |
| fhsvc | File History Service |
| FontCache | Windows Font Cache |
| GraphicsPerfSvc | Graphics Performance Service |
| hidserv | Human Interface Device Service |
| ICSSvc | Internet Connection Sharing |
| IpxlatCfgSvc | IP Translation Configuration Service |
| Kdc | Kerberos Local Key Distribution Center |
| KtmRm | KtmRm for Distributed Transaction Coordinator |
| lfsvc | Geolocation Service |
| LicenseManager | Windows License Manager Service |
| lltdsvc | Link-Layer Topology Discovery Mapper |
| MapsBroker | Downloaded Maps Manager |
| MicrosoftEdgeUpdateService | Microsoft Edge Update Service |
| MicrosoftEdgeUpdateServicem | Microsoft Edge Update Service (second instance) |
| MSDTC | Distributed Transaction Coordinator |
| NcaSvc | Network Connectivity Assistant |
| NetSetupSvc | Network Setup Service |
| NetTcpPortSharing | Net.Tcp Port Sharing |
| P2PImSv | Peer Networking Identity Manager |
| P2PSvc | Peer Networking Grouping |
| PerfHost | Performance Counter DLL Host |
| pla | Performance Logs & Alerts |
| PNRPsvc | Peer Name Resolution Protocol |
| PolicyAgent | IPsec Policy Agent |
| PrintNotify | Print Device Configuration Service |
| Spooler | Print Spooler |
| PcaSvc | Program Compatibility Assistant Service |
| RemoteAccess | Routing and Remote Access |
| RemoteRegistry | Remote Registry |
| RetailDemo | Retail Demo Service |
| SCardSvr | Smart Card |
| SensrSvc | Sensor Service |
| SensorDataService | Sensor Data Service |
| SensorMonitoringService | Sensor Monitoring Service |
| SharedAccess | Internet Connection Sharing (ICS) |
| ShellHWDetection | Shell Hardware Detection |
| SmsRouter | Microsoft Windows SMS Router Service |
| SNMPTRAP | SNMP Trap |
| Spectrum | Windows Virtual Audio Device Proxy Service |
| SSDPSRV | SSDP Discovery |
| SysMain | SysMain (Superfetch) |
| TabletInputService | Touch Keyboard and Handwriting Panel |
| TapiSrv | Telephony |
| TermService | Remote Desktop Services |
| UmRdpService | Remote Desktop Services UserMode Port Redirector |
| UsoSvc | Update Orchestrator Service |
| WaaSMedicSvc | Windows Update Medic Service |
| WalletService | Wallet Service |
| WarpJITSvc | Warp JIT Service |
| wbengine | Block Level Backup Engine |
| WbioSrvc | Windows Biometric Service |
| WcnSvc | Windows Connect Now - Config Registrar |
| Wecsvc | Windows Event Collector |
| WEPHostSvc | Windows Encryption Provider Host Service |
| WFDSConMgrSvc | Wi-Fi Direct Services Connection Manager |
| WiaRpc | Still Image Acquisition Events |
| wisvc | Windows Insider Service |
| WManSvc | Windows Management Service |
| WMPNetworkSvc | Windows Media Player Network Sharing |
| WpcMonSvc | Parental Controls |
| wscsvc | Security Center |
| WSearch | Windows Search |
| wuauserv | Windows Update |
| XboxGipSvc | Xbox Accessory Management Service |

</details>

---

## Reverting Changes

### System Restore
The recommended way to revert changes is through System Restore:
1. Open **System Restore**
2. Select a restore point created before running Atom Playbook
3. Follow the wizard to restore your system

### Manual Reversion
Most settings can be adjusted through:
- Windows Settings app
- Group Policy Editor (gpedit.msc)
- Registry Editor (for advanced users)
- Services management (services.msc)

### Reinstalling Apps
Removed apps can be reinstalled from:
- Microsoft Store
- Windows Settings > Apps > Optional Features
- Windows installation media (for system components)

> Some modifications may require Windows repair or reinstallation to fully revert.

---

## Performance Impact

| Metric | Typical Result |
|--------|----------------|
| Boot Time | 20–40% improvement |
| RAM Usage (Idle) | 30–40% reduction |
| Background Processes | 40–50% fewer |
| Disk Space | 5–10 GB freed |
| Telemetry Connections | Significantly reduced |

*Results vary based on hardware, Windows version, and selected options.*

---

## Safety & Transparency

### Data Preservation
- OneDrive files are moved to local folders before any removal
- User documents, pictures, and videos are automatically preserved
- Desktop items are backed up
- No data loss occurs during the customization process

### Open Source Transparency
- All changes are documented in YAML files
- Open-source codebase for community review
- No hidden modifications or telemetry
- Detailed execution logs are available
- No obfuscated code

### Security Considerations
- No external connections during installation
- No data collection or tracking by Atom Playbook
- Community-verified and reviewed
- Transparent and auditable code
- Users are responsible for understanding security implications

---

## Contributing

We welcome contributions from the community.

### Ways to Contribute
1. **Report Bugs** – [Open an issue](info@atom-os.com)
2. **Suggest Features** – Share ideas in discussions
3. **Submit Pull Requests** – Improve the playbook
4. **Test** – Try on different Windows versions and configurations
5. **Documentation** – Help improve guides and docs
6. **Translations** – Help translate documentation

### Development Setup
```bash
git clone https://github.com/ArabWep/Atom-Playbook.git
cd Atom-Playbook
# Review YAML files in Configuration/tasks/
# Make your changes
# Test thoroughly with AME Wizard
# Submit a pull request
