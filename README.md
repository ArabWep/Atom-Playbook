# Atom Playbook

**Windows customization playbook for advanced users, built on the AME Wizard framework.**

[![Version](https://img.shields.io/badge/version-0.5-blue.svg)](https://github.com/projectatom1/Atom-Playbook/releases)
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
| Windows 10 21H2 | 19044 | Supported |
| Windows 10 22H2 | 19045 | Supported |
| Windows 11 21H2 | 22000 | Supported |
| Windows 11 22H2 | 22621 | Supported |
| Windows 11 23H2 | 22631 | Supported |
| Windows 11 | 23620 | Supported |
| Windows 11 | 26100 | Supported |
| Windows 11 | 26200 | Supported |
| Windows 11 | 27000 | Supported |
| Windows 11 | 27100 | Supported |
| Windows 11 | 27200 | Supported |
| Windows 11 | 27300 | Supported |
| Windows 11 | 27400 | Supported |
| Windows 11 | 27500 | Supported |
| Windows 11 | 27600 | Supported |
| Windows 11 | 27700 | Supported |
| Windows 11 | 27800 | Supported |
| Windows 11 | 27900 | Supported |

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
2. Download `AtomPlaybook_0.0.5.apbx`
3. Verify file integrity (checksums provided in release)

### Step 3: Run the Playbook
1. Open **AME Wizard**
2. Drag and drop `AtomPlaybook_0.0.5.apbx` into AME Wizard
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

## Disabled Services

The following Windows services are completely stripped or disabled by the playbook for maximum efficiency:

<details>
<summary>Click to expand the complete list</summary>

| Service Name | Description |
| :--- | :--- |
| **AeLookupSvc** | Application Experience – telemetry and compatibility checks. |
| **ALG** | Application Layer Gateway Service – legacy firewall component. |
| **AppIDSvc** | Application Identity – used for AppLocker (not needed). |
| **AppMgmt** | Application Management – group policy software installation. |
| **AppReadiness** | App Readiness – prepares apps on first login; not essential. |
| **AutoTimeUpdater** | Auto Time Zone Updater – time zone can be set manually. |
| **BITS** | Background Intelligent Transfer Service – background Windows Update downloads. |
| **Browser** | Computer Browser – old network browsing (deprecated). |
| **BTAGService** | Bluetooth Audio Gateway Service – if no Bluetooth. |
| **bthserv** | Bluetooth Support Service – if no Bluetooth. |
| **CDPSvc** | Connected Devices Platform Service – sync with phones. |
| **CDPUserSvc** | Connected Devices Platform User Service – same as above. |
| **DiagTrack** | Connected User Experiences and Telemetry – major telemetry service. |
| **DispBrokerDesktopSvc** | Display Policy Service – not critical for gaming. |
| **DPS** | Diagnostic Policy Service – collects diagnostic data. |
| **WdiServiceHost** | Diagnostic Service Host – same as DPS. |
| **WdiSystemHost** | Diagnostic System Host – same as DPS. |
| **DmEnrollmentSvc** | Device Management Enrollment Service – MDM enrollment. |
| **dmwappushservice** | Device Management WAP Push – unused telemetry channel. |
| **DoSvc** | Delivery Optimization – update sharing (unused when updates off). |
| **EFS** | Encrypting File System – rarely used on custom builds. |
| **Fax** | Fax Service – obsolete component. |
| **fhsvc** | File History Service – backup architecture (not needed). |
| **FontCache** | Windows Font Cache – disabling saves memory; fonts still work fine. |
| **GraphicsPerfSvc** | GraphicsPerfSvc – graphics performance logging. |
| **hidserv** | Human Interface Device Service – safe off for standard mouse/keyboard. |
| **ICSSvc** | Internet Connection Sharing – network hotspot sharing. |
| **IpxlatCfgSvc** | IP Translation Configuration Service – IPv6 transition. |
| **Kdc** | Kerberos Local Key Distribution Center – domain network architecture only. |
| **KtmRm** | KtmRm for Distributed Transaction Coordinator – rare deployment. |
| **lfsvc** | Geolocation Service – location tracking background agent. |
| **LicenseManager** | Windows License Manager Service – activation persists; can be disabled. |
| **lltdsvc** | Link-Layer Topology Discovery Mapper – local network mapping tool. |
| **MapsBroker** | Downloaded Maps Manager – handles offline desktop maps. |
| **MicrosoftEdgeUpdateService** | Microsoft Edge Update Service – updates Edge (user managed). |
| **MicrosoftEdgeUpdateServicem**| Microsoft Edge Update Service (second instance). |
| **MSDTC** | Distributed Transaction Coordinator – legacy database coordination. |
| **NcaSvc** | Network Connectivity Assistant – corporate deployment framework. |
| **NetSetupSvc** | Network Setup Service – redundant deployment tracking. |
| **NetTcpPortSharing** | Net.Tcp Port Sharing – architectural framework not used. |
| **P2PImSv** | Peer Networking Identity Manager – legacy peer-to-peer structure. |
| **P2PSvc** | Peer Networking Grouping – legacy infrastructure. |
| **PerfHost** | Performance Counter DLL Host – infrastructure diagnostics. |
| **pla** | Performance Logs & Alerts – logging overhead background agent. |
| **PNRPsvc** | Peer Name Resolution Protocol – unused networking layer. |
| **PolicyAgent** | IPsec Policy Agent – IPsec VPN routing infrastructure. |
| **PrintNotify** | Print Device Configuration Service – unnecessary if no printer used. |
| **Spooler** | Print Spooler – handles core printer configurations. |
| **PcaSvc** | Program Compatibility Assistant Service – runs background diagnostic scans. |
| **RemoteAccess** | Routing and Remote Access – corporate dial-up/routing layer. |
| **RemoteRegistry** | Remote Registry – critical security and performance optimization risk. |
| **RetailDemo** | Retail Demo Service – pre-installed loop presentation bloatware. |
| **SCardSvr** | Smart Card – physical hardware authentication infrastructure. |
| **SensrSvc** | Sensor Service – redundant infrastructure on desktop hardware. |
| **SensorDataService** | Sensor Data Service – system environment scanning profiles. |
| **SensorMonitoringService** | Sensor Monitoring Service – environment evaluation tracking. |
| **SharedAccess** | Internet Connection Sharing (ICS) – mobile hotspot layer. |
| **ShellHWDetection** | Shell Hardware Detection – powers standard device AutoPlay. |
| **SmsRouter** | Microsoft Windows SMS Router Service – mobile device messaging layer. |
| **SNMPTRAP** | SNMP Trap – legacy tracking layer protocols. |
| **Spectrum** | Windows Virtual Audio Device Proxy Service – diagnostic audio logging. |
| **SSDPSRV** | SSDP Discovery – automatic DLNA hardware discovery. |
| **SysMain** | SysMain (Superfetch) – addresses potential extreme background disk bottlenecks. |
| **TabletInputService**| Touch Keyboard and Handwriting Panel – completely unused on standard displays. |
| **TapiSrv** | Telephony – obsolete legacy infrastructure. |
| **TermService** | Remote Desktop Services – remote server control tracking. |
| **UmRdpService** | Remote Desktop Services UserMode Port Redirector. |
| **UsoSvc** | Update Orchestrator Service – primary component of Windows Update. |
| **WaaSMedicSvc** | WaaSMedicSvc – Windows Update background repair agent. |
| **WalletService** | WalletService – completely unused transaction interface. |
| **WarpJITSvc** | Warp JIT Service – dynamic execution optimization tracking. |
| **wbengine** | Block Level Backup Engine – system recovery platform services. |
| **WbioSrvc** | Windows Biometric Service – fingerprint/facial sign-in layer. |
| **WcnSvc** | Windows Connect Now - Config Registrar – wireless network automation setup. |
| **Wecsvc** | Windows Event Collector – remote server diagnostic syncing. |
| **WEPHostSvc** | Windows Encryption Provider Host Service – secondary cryptographic framework. |
| **WFDSConMgrSvc** | Wi-Fi Direct Services Connection Manager – unused desktop network layer. |
| **WiaRpc** | Still Image Acquisition Events – tracking interface for external scanners. |
| **wisvc** | Windows Insider Service – monitoring system build configurations. |
| **WManSvc** | Windows Management Service – non-essential background service management. |
| **WMPNetworkSvc** | Windows Media Player Network Sharing – digital media distribution system. |
| **WpcMonSvc** | Parental Controls – user account filtering management software. |
| **wscsvc** | Security Center – managing desktop alert notifications only. |
| **WSearch** | Windows Search – removes file content indexing overhead; standard query continues. |
| **wuauserv** | Windows Update – completely controls automated operating system alterations. |
| **XboxGipSvc** | Xbox Accessory Management Service – peripheral hardware syncing profiles. |

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
1. **Report Bugs** – [Open an issue](https://discord.com/invite/9ZCgxhaYV6)
2. **Suggest Features** – Share ideas in discussions
3. **Submit Pull Requests** – Improve the playbook
4. **Test** – Try on different Windows versions and configurations
5. **Documentation** – Help improve guides and docs
6. **Translations** – Help translate documentation

### Development Setup
```bash
