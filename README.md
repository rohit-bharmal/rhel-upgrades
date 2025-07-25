# RHEL Upgrade Scripts Collection

A comprehensive collection of scripts to automate and guide the upgrade process between RHEL versions. These scripts help system administrators perform safe and reliable upgrades while following Red Hat's recommended practices.

## 💻 Supported Architectures

These upgrade scripts are designed for:

- 64-bit Intel and AMD (x86_64)
- 64-bit ARM (aarch64)

If you're running RHEL on one of these architectures, these scripts are compatible with your system.

## 🎯 Supported Upgrade Paths

- [RHEL 7 to RHEL 8](scripts/using-cdn/rhel7-to-8/README.md)
- [RHEL 8 to RHEL 9](scripts/using-cdn/rhel8-to-9/README.md)
- [RHEL 9 to RHEL 10](scripts/using-cdn/rhel9-to-10/README.md)

## 🔄 Upgrade Process Overview

Each upgrade path follows a consistent 3-phase process:

### Phase 1: Pre-Upgrade Preparation

- System requirements verification
- Subscription validation
- Repository configuration
- Critical configuration backup
- Installation of upgrade tools

### Phase 2: Leapp Upgrade

- Pre-upgrade analysis
- Issue resolution
- System upgrade
- Automatic reboot

### Phase 3: Post-Upgrade Cleanup

- Upgrade verification
- System cleanup
- Service validation
- Configuration updates

## 📋 Prerequisites

Before starting any upgrade:

1. **System Requirements**

   - Active RHEL subscription
   - Minimum 5GB free space in /var
   - Complete system backup or VM snapshot
   - Working internet connection

2. **Documentation**

   - Review the specific upgrade path documentation
   - Check [documentation](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux)
   - Understand the upgrade process and potential risks

3. **Testing**
   - Test the upgrade process in a non-production environment
   - Verify application compatibility
   - Plan for downtime during the upgrade

## 🚀 Quick Start

1. Choose your upgrade path directory:

   ```bash
   cd scripts/using-cdn/rhel7-to-8/  # For RHEL 7 to 8
   cd scripts/using-cdn/rhel8-to-9/  # For RHEL 8 to 9
   cd scripts/using-cdn/rhel9-to-10/ # For RHEL 9 to 10
   ```

2. Run the pre-upgrade script:

   ```bash
   sudo ./pre-upgrade.sh
   ```

3. Follow the Leapp upgrade process:

   ```bash
   leapp preupgrade
   # Review the pre-upgrade report
   leapp upgrade
   ```

4. After reboot, run the post-upgrade script:
   ```bash
   sudo ./post-upgrade.sh
   ```

## 📝 Script Features

- Comprehensive system checks
- Detailed logging
- Error handling and validation
- Automated repository management
- Configuration backups
- Service verification
- Progress reporting

## ⚠️ Important Notes

1. **Backup**: Always create a full system backup before upgrading
2. **Testing**: Test in a non-production environment first
3. **Review**: Read all documentation before proceeding
4. **Support**: Have Red Hat support information ready
5. **Downtime**: Plan for system downtime during upgrade
6. **Verification**: Test system functionality after upgrade

## 🔍 Troubleshooting

- Check logs in `/var/log/pre-upgrade/` and `/var/log/post-upgrade/`
- Review Leapp logs in `/var/log/leapp/`
- Consult the upgrade report generated after completion
- Contact Red Hat support if needed

## 🤝 Contributing

Contributions are welcome! Please feel free to submit pull requests or create issues for improvements.

## ⚖️ License

This project is licensed under the MIT License - see the LICENSE file for details.

## ⚠️ Disclaimer

These scripts are provided as-is, without warranty. Always test thoroughly and maintain backups before performing system upgrades.
