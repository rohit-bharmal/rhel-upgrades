# RHEL 8 to 9 Upgrade Scripts

This collection of scripts automates the upgrade process from RHEL 8 to RHEL 9, providing a structured approach to system upgrades.

⚠️ **WARNING:** Use at your own risk. Always back up your system before running upgrade scripts.

## ✅ Features

- Comprehensive system readiness checks
- Uses official `leapp` upgrade tools
- Provides detailed logs and upgrade status
- Minimal downtime with semi-automated steps
- Pre and post-upgrade automation scripts
- Handles common upgrade blockers

## 🔄 Recommended 3-Phase Upgrade Process

### Phase 1: Pre-Upgrade Preparation

Run the pre-upgrade script to prepare your system:

```bash
curl -O https://raw.githubusercontent.com/rohit-bharmal/rhel-upgrades/main/scripts/using-cdn/rhel8-to-9/pre-upgrade.sh
chmod +x pre-upgrade.sh
sudo ./pre-upgrade.sh
```

The pre-upgrade script will:

- Verify system requirements
- Check for available disk space
- Validate current RHEL subscription
- Back up critical configuration files
- Install required upgrade tools
- Configure necessary repositories
- Run preliminary health checks

### Phase 2: Leapp Upgrade Process

After pre-upgrade preparation, manually run the Leapp upgrade:

```bash
# 1. Run pre-upgrade analysis
leapp preupgrade

# 2. Review the pre-upgrade report
less /var/log/leapp/leapp-report.txt

# 3. Resolve any reported issues

# 4. When ready, initiate the upgrade
leapp upgrade
```

The system will reboot automatically after the upgrade process.

### Phase 3: Post-Upgrade Cleanup

After the system reboots into RHEL 9, run the post-upgrade script:

```bash
curl -O https://raw.githubusercontent.com/rohit-bharmal/rhel-upgrades/main/scripts/using-cdn/rhel8-to-9/post-upgrade.sh
chmod +x post-upgrade.sh
sudo ./post-upgrade.sh
```

The post-upgrade script will:

- Verify successful upgrade
- Clean up temporary files
- Update system configurations
- Restore backed-up configurations if needed
- Validate system services
- Generate upgrade completion report

## 📝 Logs and Reports

- Pre-upgrade logs: `/var/log/pre-upgrade/`
- Leapp upgrade logs: `/var/log/leapp/`
- Post-upgrade logs: `/var/log/post-upgrade/`

## 🔍 Troubleshooting

If you encounter issues during any phase:

1. Check the respective log files
2. Review the Leapp pre-upgrade report
3. Solve Inhibitors and then run leapp upgrade

## 📋 Prerequisites

- Active RHEL subscription
- RHEL 8.0 or later
- Recent system backup
- Working internet connection
