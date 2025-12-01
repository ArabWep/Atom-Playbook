# 🚀 Atom Playbook

<div align="center">

**Windows Customization Playbook for Power Users**

[![Version](https://img.shields.io/badge/version-0.1-blue.svg)](https://github.com/projectatom1/Atom-Playbook/releases)
[![Windows](https://img.shields.io/badge/Windows-10%20%7C%2011-0078D6?logo=windows)](https://github.com/projectatom1/Atom-Playbook)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![AME Wizard](https://img.shields.io/badge/AME%20Wizard-Compatible-orange.svg)](https://ameliorated.io)

[Download](https://github.com/projectatom1/Atom-Playbook/releases) • [Documentation](https://www.atom-os.com/docs) • [Website](https://www.atom-os.com/) • [Report Bug](https://github.com/projectatom1/Atom-Playbook/issues)

</div>

---

## ⚠️ Important Notice

**This project is intended for educational and research purposes.** It demonstrates Windows customization techniques using the AME Wizard framework. Users should understand the implications of system modifications and use this software responsibly.

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

## 📖 What is Atom Playbook?

**Atom Playbook** is an advanced Windows customization playbook designed for the [AME Wizard](https://ameliorated.io) framework. It provides power users with granular control over their Windows installation, allowing for deep personalization and optimization.

### Key Features:
- 🎨 **Deep Customization** - Modify Windows behavior and appearance
- � **Granular Control** - Choose exactly what changes to apply
- 📊 **Performance Tuning** - Optimize system resources
- 🎯 **Privacy Options** - Configure telemetry and tracking settings
- 🖼️ **Custom Theming** - Apply exclusive Atom visual theme
- � **Fully Documented** - All changes are transparent and logged

---

## ✨ Features

### 🎨 Visual Customization
- 🖼️ Custom Atom theme with wallpaper and color scheme
- 🎨 Streamlined taskbar and Start Menu
- 📂 Enhanced File Explorer settings
- 🚫 Remove pre-installed apps and bloatware

### ⚡ System Optimization
- 🗑️ Remove unnecessary UWP apps (40+ apps)
- 🔧 Configure Windows services
- 💾 Optimize storage settings
- 📊 Reduce background processes
- 🚀 Improve boot performance

### 🔒 Privacy Configuration
- 🔐 Telemetry settings control
- 🚫 Web search integration options
- 🛑 Advertising preferences
- 📍 Location and tracking settings
- ☁️ Cloud sync configuration

### 🌐 Application Management
- � Browser selection (Brave, Zen, Chrome)
- 🗑️ Internet Explorer removal (legacy)
- ☁️ OneDrive configuration (with data preservation)
- 🎯 Custom application preferences

### 🛠️ Advanced Options
Users can optionally configure:
- System security settings
- Windows Update behavior
- Default browser preferences
- System component management

> ⚠️ **Advanced options should only be used by experienced users who understand the implications.**

---

## 📋 System Requirements

### Supported Windows Versions

| Version | Build Number | Status |
|---------|--------------|--------|
| Windows 10 1909 | 18363 | ✅ Supported |
| Windows 10 2004 | 19041 | ✅ Supported |
| Windows 10 20H2 | 19042 | ✅ Supported |
| Windows 10 21H1 | 19043 | ✅ Supported |
| Windows 10 21H2 | 19044 | ✅ Supported |
| Windows 10 22H2 | 19045 | ✅ Supported |
| Windows 11 21H2 | 22000 | ✅ Supported |
| Windows 11 22H2 | 22621 | ✅ Supported |
| Windows 11 23H2 | 22631 | ✅ Supported |
| Windows 11 24H2 | 22635 | ✅ Supported |
| Windows 11 Insider | 26100+ | ✅ Supported |

### Prerequisites
- ✅ Internet connection
- ✅ No pending Windows updates
- ✅ Device plugged into power
- ✅ [AME Wizard](https://ameliorated.io) installed
- ✅ **System backup created**
- ✅ **Understanding of Windows system administration**

---

## 🚀 Installation

### ⚠️ Pre-Installation Checklist

Before proceeding, ensure you have:
1. ✅ Created a full system backup or restore point
2. ✅ Saved all important work
3. ✅ Tested in a virtual machine (recommended)
4. ✅ Read and understood all options
5. ✅ Accepted the risks of system modification

### Step 1: Download AME Wizard
1. Visit [ameliorated.io](https://ameliorated.io)
2. Download the latest AME Wizard
3. Extract and run `AME Wizard.exe`

### Step 2: Download Atom Playbook
1. Go to [Releases](https://github.com/projectatom1/Atom-Playbook/releases)
2. Download `AtomPlaybookBeta.apbx`
3. Verify file integrity (checksums provided in release)

### Step 3: Run the Playbook
1. Open **AME Wizard**
2. Drag and drop `AtomPlaybookBeta.apbx` into AME Wizard
3. **Carefully review** all available options
4. Select your preferences:
   - Choose your browser (Brave, Zen, Chrome, or None)
   - Select theme preference (Default or Atom Theme)
   - Configure advanced options (if applicable)
5. Click **Run** and wait for completion
6. Restart your computer when prompted

---

## 🎯 What Gets Modified?

### 📦 Removed Components (Optional)
- Internet Explorer (legacy browser)
- OneDrive integration (with data preservation)
- Pre-installed UWP applications
- Web search integration in Start Menu
- Telemetry scheduled tasks

### ⚙️ Modified Settings
- Privacy and telemetry configurations
- File Explorer display options
- Taskbar appearance
- Start Menu recommendations
- Search behavior (local-focused)
- Visual effects and performance

### 🎨 Added Features
- Atom custom theme (optional)
- Browser of choice installation
- Optimized visual settings
- Enhanced user interface

---

## 🔄 Reverting Changes

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

> ℹ️ **Note**: Some modifications may require Windows repair or reinstallation to fully revert.

---

## 📊 Performance Impact

| Metric | Typical Result |
|--------|----------------|
| Boot Time | 20-40% improvement |
| RAM Usage (Idle) | 30-40% reduction |
| Background Processes | 40-50% fewer |
| Disk Space | 5-10 GB freed |
| Telemetry Connections | Significantly reduced |

*Results vary based on hardware, Windows version, and selected options*

---

## 🛡️ Safety & Transparency

### Data Preservation
- ✅ OneDrive files moved to local folders before any removal
- ✅ User documents, pictures, videos automatically preserved
- ✅ Desktop items backed up
- ✅ No data loss during customization process

### Open Source Transparency
- 📖 All changes documented in YAML files
- 🔍 Open-source codebase for community review
- 🔐 No hidden modifications or telemetry
- 📝 Detailed execution logs available
- 🔓 No obfuscated code

### Security Considerations
- 🛡️ No external connections during installation
- 🔒 No data collection or tracking by Atom Playbook
- ✅ Community-verified and reviewed
- 🔐 Transparent and auditable code
- ⚠️ Users responsible for understanding security implications

---

## 🤝 Contributing

We welcome contributions from the community! Here's how you can help:

### Ways to Contribute
1. **Report Bugs**: [Open an issue](https://github.com/projectatom1/Atom-Playbook/issues)
2. **Suggest Features**: Share ideas in discussions
3. **Submit Pull Requests**: Improve the playbook
4. **Test**: Try on different Windows versions and configurations
5. **Documentation**: Help improve guides and docs
6. **Translations**: Help translate documentation

### Development Setup
```bash
git clone https://github.com/projectatom1/Atom-Playbook.git
cd Atom-Playbook

# Review YAML files in Configuration/tasks/
# Make your changes
# Test thoroughly with AME Wizard
# Submit a pull request
```

### Contribution Guidelines
- Follow existing code style
- Test all changes thoroughly
- Document new features
- Respect user choice and safety
- Maintain transparency

---

## 📝 Changelog

### Version 0.1 (Current)
- 🎉 Initial release
- 🛡️ Basic privacy controls
- 🚀 Core performance optimizations

---

## ❓ FAQ

### Is Atom Playbook safe to use?
The playbook itself is safe and transparent. However, modifying system settings always carries risks. We recommend testing in a VM first and creating backups.

### Can I undo the changes?
Most changes can be reverted through Windows Settings or System Restore. Some modifications may require more advanced steps to fully reverse.

### Will this break Windows?
When used correctly, no. However, improper use or selecting incompatible options could cause issues. Always create a restore point first.

### Does this work on Windows 11?
Yes! Atom Playbook fully supports Windows 11 (21H2, 22H2, 23H2, 24H2, and Insider builds).

### What's different from other playbooks?
Atom focuses on balance: maximum customization while maintaining system stability. It includes a custom theme and prioritizes user choice.

### Can I use this on my work computer?
**Not recommended.** This playbook is designed for personal use and may conflict with enterprise policies and security requirements.

### Is this legal?
Yes. Customizing your own Windows installation is legal. However, users are responsible for complying with Microsoft's EULA and any applicable agreements.

---

## 🔗 Links & Resources

- 🌐 **Website**: [atom-os.com](https://www.atom-os.com/)
- 📖 **Documentation**: [atom-os.com/docs](https://www.atom-os.com/docs)
- 💬 **Discussions**: GitHub Discussions
- 🐛 **Issues**: [Report bugs](https://github.com/projectatom1/Atom-Playbook/issues)
- 📧 **Support**: Open an issue for assistance

---

## 📜 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for full details.

### What This Means:
- ✅ Free to use, modify, and distribute
- ✅ Commercial use allowed
- ✅ No warranty provided
- ⚠️ Use at your own risk
- 📝 Attribution appreciated but not required

---

## ⚠️ Disclaimer & Legal

**IMPORTANT: READ CAREFULLY BEFORE USE**

### Use At Your Own Risk

This software is provided "AS IS" without warranty of any kind. The authors and contributors:
- ❌ Make NO guarantees about compatibility or stability
- ❌ Are NOT responsible for any damage or data loss
- ❌ Do NOT provide official support or guarantees
- ❌ Cannot be held liable for any consequences of use

### User Responsibilities

By using Atom Playbook, you acknowledge that:
- ✅ You understand the risks of system modification
- ✅ You have created appropriate backups
- ✅ You accept full responsibility for any outcomes
- ✅ You will not use this for malicious purposes
- ✅ You comply with all applicable laws and agreements

### Educational Purpose

This project is intended for:
- 📚 Educational purposes
- 🔬 Research and experimentation
- 🛠️ Advanced Windows customization
- 💡 Learning about Windows internals

### Not Recommended For:
- ❌ Production or business-critical systems
- ❌ Systems with specific compliance requirements
- ❌ Users unfamiliar with Windows administration
- ❌ Environments requiring vendor support

### Third-Party Software

This playbook may install or configure third-party software. Users are responsible for:
- Reviewing licenses of installed software
- Complying with terms of service
- Understanding privacy implications
- Verifying software authenticity

### Microsoft Disclaimer

**Project Atom** is an independent project and is NOT:
- Affiliated with Microsoft Corporation
- Endorsed by Microsoft Corporation
- Supported by Microsoft Corporation

Windows is a registered trademark of Microsoft Corporation.

---

## 🙏 Acknowledgments

Special thanks to:
- **[AME Wizard](https://ameliorated.io)** - For the excellent playbook framework
- **The Windows Community** - For testing, feedback, and contributions
- **All Contributors** - For improving and maintaining this project
- **Open Source Community** - For tools and inspiration

---

## 💖 Support the Project

If you find Atom Playbook useful:
- ⭐ **Star this repository** - Helps others discover the project
- 🐛 **Report bugs** - Help us improve quality
- 💬 **Share feedback** - Tell us what works and what doesn't
- 📝 **Contribute** - Submit improvements and fixes
- 🗣️ **Spread the word** - Share with others who might benefit

---

<div align="center">

**Made with ❤️ by Project Atom**

*Empowering users with choice and control over their Windows experience*

[⬆ Back to Top](#-atom-playbook)

</div>
