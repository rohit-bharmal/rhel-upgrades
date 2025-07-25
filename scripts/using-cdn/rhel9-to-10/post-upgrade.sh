#!/bin/bash

#==============================================================================
# Red Hat Enterprise Linux Upgrade Script  
# Post-Upgrade Cleanup - Phase 3 of 3
# Generated by: RHEL Upgrade Helper
# Source Version: RHEL 9
# Target Version: RHEL 10
# Repository Type: Red Hat Content Delivery Network with RHSM
#==============================================================================

# This script performs PHASE 3: Post-upgrade cleanup and verification
# Run this script AFTER:
# 1. System has been upgraded to RHEL 10
# 2. System has rebooted successfully
# 3. You have verified basic system functionality

# IMPORTANT SAFETY WARNINGS:
# 1. DO NOT RUN THIS SCRIPT ON PRODUCTION SYSTEMS WITHOUT TESTING FIRST
# 2. ENSURE YOU HAVE A COMPLETE BACKUP OR VM SNAPSHOT BEFORE PROCEEDING
# 3. REVIEW EACH COMMAND BEFORE EXECUTION
# 4. THIS SCRIPT REQUIRES ROOT PRIVILEGES
# 5. SOME STEPS REQUIRE MANUAL INTERVENTION AND CANNOT BE AUTOMATED

# Exit on any error
set -e

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Simple logging functions
step_echo() {
    echo -e "\n${CYAN}================================================================================${NC}"
    echo -e "${BOLD}${BLUE}STEP $1: $2${NC}"
    echo -e "${CYAN}================================================================================${NC}"
}

info_echo() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

warn_echo() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

error_echo() {
    echo -e "${RED}[ERROR]${NC} $1"
    exit 1
}

success_echo() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

# Check if running as root
if [[ $EUID -ne 0 ]]; then
    error_echo "This script must be run as root. Use: sudo $0"
fi

# Initial safety check
echo -e "${RED}⚠️  CRITICAL WARNING ⚠️${NC}"
echo "This script will clean up after RHEL 9 to RHEL 10 upgrade."
echo "Ensure you have:"
echo "  • Complete system backup or VM snapshot"
echo "  • Tested this procedure in a non-production environment"
echo "  • Read and understood all upgrade documentation"
echo "  • Successfully upgraded to RHEL 10 and rebooted"
echo ""
read -p "Do you want to continue? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Upgrade cancelled by user."
    exit 0
fi

echo -e "\n${GREEN}Starting Post-Upgrade Cleanup...${NC}\n"


# Step 1
step_echo 1 "[object Object]"
    # If your system is registered by using an account with SCA disabled, verify that the Red Hat Linux Server subscription is attached, the product name is Server, and the status is Subscribed.
    info_echo "Executing: subscription-manager list --installed"
    subscription-manager list --installed || { error_echo "Command failed: subscription-manager list --installed"; exit 1; }



#==============================================================================
# VERIFYING THE POST-UPGRADE STATE OF THE RHEL 10 SYSTEM
#==============================================================================
echo -e "\n${CYAN}Starting: Verifying the post-upgrade state of the RHEL 10 system${NC}\n"

# Step 2
step_echo 2 "Check the OS kernel version. For example:"
    # Check the OS kernel version. For example:
    info_echo "Executing: uname -r"
    uname -r || { error_echo "Command failed: uname -r"; exit 1; }

    info_echo "Executing: 6.12.0-55.2.1.el10_0.x86_64"
    6.12.0-55.2.1.el10_0.x86_64 || { error_echo "Command failed: 6.12.0-55.2.1.el10_0.x86_64"; exit 1; }



# Step 3
step_echo 3 "Verify that the correct product is installed:"
    # Verify that the correct product is installed:
    info_echo "Executing: subscription-manager list --installed"
    subscription-manager list --installed || { error_echo "Command failed: subscription-manager list --installed"; exit 1; }



# Step 4
step_echo 4 "Verify that the release version is set to the target OS version immediately after the upgrade:"
    # Verify that the release version is set to the target OS version immediately after the upgrade:
    info_echo "Executing: subscription-manager release"
    subscription-manager release || { error_echo "Command failed: subscription-manager release"; exit 1; }



#==============================================================================
# AFTER PERFORMING THE UPGRADE, COMPLETE THE FOLLOWING TASKS:
#==============================================================================
echo -e "\n${CYAN}Starting: After performing the upgrade, complete the following tasks:${NC}\n"

# Step 5
step_echo 5 "[object Object]"
    # To manually remove packages from the exclude list, edit the  /etc/dnf/dnf.conf  configuration file and remove the desired  Leapp  packages from the  exclude  list.
    info_echo "Executing: dnf -y config-manager --save --setopt exclude=''"
    dnf -y config-manager --save --setopt exclude='' || { error_echo "Command failed: dnf -y config-manager --save --setopt exclude=''"; exit 1; }



# Step 6
step_echo 6 "Locate remaining RHEL 9 packages:"
    # Locate remaining RHEL 9 packages:
    info_echo "Executing: rpm -qa | grep -e '\.el[789]' | grep -vE '^(gpg-pubkey|libmodulemd|katello-ca-consumer)' | sort"
    rpm -qa | grep -e '\.el[789]' | grep -vE '^(gpg-pubkey|libmodulemd|katello-ca-consumer)' | sort || { error_echo "Command failed: rpm -qa | grep -e '\.el[789]' | grep -vE '^(gpg-pubkey|libmodulemd|katello-ca-consumer)' | sort"; exit 1; }



# Step 7
step_echo 7 "[object Object]"
    # Remove remaining  Leapp  dependency packages:
    info_echo "Executing: dnf -y remove leapp-deps-el10 leapp-repository-deps-el10"
    dnf -y remove leapp-deps-el10 leapp-repository-deps-el10 || { error_echo "Command failed: dnf -y remove leapp-deps-el10 leapp-repository-deps-el10"; exit 1; }



# Step 8
step_echo 8 "Optional: Remove all remaining upgrade-related data from the system:"
    # Optional: Remove all remaining upgrade-related data from the system:
    warn_echo "IMPORTANT: Removing this data might limit Red Hat Support's ability to investigate and troubleshoot post-upgrade problems."
    info_echo "Executing: rm -rf /var/log/leapp /root/tmp_leapp_py3 /var/lib/leapp"
    rm -rf /var/log/leapp /root/tmp_leapp_py3 /var/lib/leapp || { error_echo "Command failed: rm -rf /var/log/leapp /root/tmp_leapp_py3 /var/lib/leapp"; exit 1; }



# Step 9
step_echo 9 "Disable DNF repositories whose packages are not RHEL 10-compatible. Repositories managed by RHSM are handled automatically. To disable these repositories:"
    # Disable DNF repositories whose packages are not RHEL 10-compatible. Repositories managed by RHSM are handled automatically. To disable these repositories:
    info_echo "Executing: # Disable source version repository: rhel-9-for-x86_64-baseos-rpms
if subscription-manager repos --list-enabled | grep -q "rhel-9-for-x86_64-baseos-rpms" 2>/dev/null; then
    info_echo "Disabling repository: rhel-9-for-x86_64-baseos-rpms"
    dnf -y config-manager --set-disabled rhel-9-for-x86_64-baseos-rpms || warn_echo "Could not disable rhel-9-for-x86_64-baseos-rpms"
else
    info_echo "Repository rhel-9-for-x86_64-baseos-rpms is not enabled, skipping"
fi

# Disable source version repository: rhel-9-for-x86_64-appstream-rpms
if subscription-manager repos --list-enabled | grep -q "rhel-9-for-x86_64-appstream-rpms" 2>/dev/null; then
    info_echo "Disabling repository: rhel-9-for-x86_64-appstream-rpms"
    dnf -y config-manager --set-disabled rhel-9-for-x86_64-appstream-rpms || warn_echo "Could not disable rhel-9-for-x86_64-appstream-rpms"
else
    info_echo "Repository rhel-9-for-x86_64-appstream-rpms is not enabled, skipping"
fi

# Disable source version repository: codeready-builder-for-rhel-9-x86_64-rpms
if subscription-manager repos --list-enabled | grep -q "codeready-builder-for-rhel-9-x86_64-rpms" 2>/dev/null; then
    info_echo "Disabling repository: codeready-builder-for-rhel-9-x86_64-rpms"
    dnf -y config-manager --set-disabled codeready-builder-for-rhel-9-x86_64-rpms || warn_echo "Could not disable codeready-builder-for-rhel-9-x86_64-rpms"
else
    info_echo "Repository codeready-builder-for-rhel-9-x86_64-rpms is not enabled, skipping"
fi

# Disable source version repository: rhel-9-for-x86_64-supplementary-rpms
if subscription-manager repos --list-enabled | grep -q "rhel-9-for-x86_64-supplementary-rpms" 2>/dev/null; then
    info_echo "Disabling repository: rhel-9-for-x86_64-supplementary-rpms"
    dnf -y config-manager --set-disabled rhel-9-for-x86_64-supplementary-rpms || warn_echo "Could not disable rhel-9-for-x86_64-supplementary-rpms"
else
    info_echo "Repository rhel-9-for-x86_64-supplementary-rpms is not enabled, skipping"
fi"
    # Disable source version repository: rhel-9-for-x86_64-baseos-rpms
if subscription-manager repos --list-enabled | grep -q "rhel-9-for-x86_64-baseos-rpms" 2>/dev/null; then
    info_echo "Disabling repository: rhel-9-for-x86_64-baseos-rpms"
    dnf -y config-manager --set-disabled rhel-9-for-x86_64-baseos-rpms || warn_echo "Could not disable rhel-9-for-x86_64-baseos-rpms"
else
    info_echo "Repository rhel-9-for-x86_64-baseos-rpms is not enabled, skipping"
fi

# Disable source version repository: rhel-9-for-x86_64-appstream-rpms
if subscription-manager repos --list-enabled | grep -q "rhel-9-for-x86_64-appstream-rpms" 2>/dev/null; then
    info_echo "Disabling repository: rhel-9-for-x86_64-appstream-rpms"
    dnf -y config-manager --set-disabled rhel-9-for-x86_64-appstream-rpms || warn_echo "Could not disable rhel-9-for-x86_64-appstream-rpms"
else
    info_echo "Repository rhel-9-for-x86_64-appstream-rpms is not enabled, skipping"
fi

# Disable source version repository: codeready-builder-for-rhel-9-x86_64-rpms
if subscription-manager repos --list-enabled | grep -q "codeready-builder-for-rhel-9-x86_64-rpms" 2>/dev/null; then
    info_echo "Disabling repository: codeready-builder-for-rhel-9-x86_64-rpms"
    dnf -y config-manager --set-disabled codeready-builder-for-rhel-9-x86_64-rpms || warn_echo "Could not disable codeready-builder-for-rhel-9-x86_64-rpms"
else
    info_echo "Repository codeready-builder-for-rhel-9-x86_64-rpms is not enabled, skipping"
fi

# Disable source version repository: rhel-9-for-x86_64-supplementary-rpms
if subscription-manager repos --list-enabled | grep -q "rhel-9-for-x86_64-supplementary-rpms" 2>/dev/null; then
    info_echo "Disabling repository: rhel-9-for-x86_64-supplementary-rpms"
    dnf -y config-manager --set-disabled rhel-9-for-x86_64-supplementary-rpms || warn_echo "Could not disable rhel-9-for-x86_64-supplementary-rpms"
else
    info_echo "Repository rhel-9-for-x86_64-supplementary-rpms is not enabled, skipping"
fi || { error_echo "Command failed: # Disable source version repository: rhel-9-for-x86_64-baseos-rpms
if subscription-manager repos --list-enabled | grep -q "rhel-9-for-x86_64-baseos-rpms" 2>/dev/null; then
    info_echo "Disabling repository: rhel-9-for-x86_64-baseos-rpms"
    dnf -y config-manager --set-disabled rhel-9-for-x86_64-baseos-rpms || warn_echo "Could not disable rhel-9-for-x86_64-baseos-rpms"
else
    info_echo "Repository rhel-9-for-x86_64-baseos-rpms is not enabled, skipping"
fi

# Disable source version repository: rhel-9-for-x86_64-appstream-rpms
if subscription-manager repos --list-enabled | grep -q "rhel-9-for-x86_64-appstream-rpms" 2>/dev/null; then
    info_echo "Disabling repository: rhel-9-for-x86_64-appstream-rpms"
    dnf -y config-manager --set-disabled rhel-9-for-x86_64-appstream-rpms || warn_echo "Could not disable rhel-9-for-x86_64-appstream-rpms"
else
    info_echo "Repository rhel-9-for-x86_64-appstream-rpms is not enabled, skipping"
fi

# Disable source version repository: codeready-builder-for-rhel-9-x86_64-rpms
if subscription-manager repos --list-enabled | grep -q "codeready-builder-for-rhel-9-x86_64-rpms" 2>/dev/null; then
    info_echo "Disabling repository: codeready-builder-for-rhel-9-x86_64-rpms"
    dnf -y config-manager --set-disabled codeready-builder-for-rhel-9-x86_64-rpms || warn_echo "Could not disable codeready-builder-for-rhel-9-x86_64-rpms"
else
    info_echo "Repository codeready-builder-for-rhel-9-x86_64-rpms is not enabled, skipping"
fi

# Disable source version repository: rhel-9-for-x86_64-supplementary-rpms
if subscription-manager repos --list-enabled | grep -q "rhel-9-for-x86_64-supplementary-rpms" 2>/dev/null; then
    info_echo "Disabling repository: rhel-9-for-x86_64-supplementary-rpms"
    dnf -y config-manager --set-disabled rhel-9-for-x86_64-supplementary-rpms || warn_echo "Could not disable rhel-9-for-x86_64-supplementary-rpms"
else
    info_echo "Repository rhel-9-for-x86_64-supplementary-rpms is not enabled, skipping"
fi"; exit 1; }



# Step 10
step_echo 10 "Remove the existing rescue kernel and initial RAM disk:"
    # Remove the existing rescue kernel and initial RAM disk:
    # Check if files exist before removing
    if ls /boot/vmlinuz-*rescue* /boot/initramfs-*rescue* 1> /dev/null 2>&1; then
      info_echo "Executing: rm /boot/vmlinuz-*rescue* /boot/initramfs-*rescue*"
      rm /boot/vmlinuz-*rescue* /boot/initramfs-*rescue* || { error_echo "Command failed: rm /boot/vmlinuz-*rescue* /boot/initramfs-*rescue*"; exit 1; }
    else
      info_echo "No files matching /boot/vmlinuz-*rescue* /boot/initramfs-*rescue* found, skipping removal"
    fi



# Step 11
step_echo 11 "Reinstall the rescue kernel and related initial RAM disk:"
    # Reinstall the rescue kernel and related initial RAM disk:
    info_echo "Executing: /usr/lib/kernel/install.d/51-dracut-rescue.install add "$(uname -r)" /boot "/boot/vmlinuz-$(uname -r)""
    /usr/lib/kernel/install.d/51-dracut-rescue.install add "$(uname -r)" /boot "/boot/vmlinuz-$(uname -r)" || { error_echo "Command failed: /usr/lib/kernel/install.d/51-dracut-rescue.install add "$(uname -r)" /boot "/boot/vmlinuz-$(uname -r)""; exit 1; }



# Step 12
step_echo 12 "[object Object]"
    # If your system is on IBM Z architecture, update the  zipl  bootloader:
    info_echo "Executing: zipl"
    zipl || { error_echo "Command failed: zipl"; exit 1; }



# Step 13
step_echo 13 "Verify that the previously removed rescue kernel and rescue initial RAM disk files have been created for the current kernel:"
    # Verify that the previously removed rescue kernel and rescue initial RAM disk files have been created for the current kernel:
    info_echo "Executing: ls /boot/vmlinuz-*rescue* /boot/initramfs-*rescue*"
    ls /boot/vmlinuz-*rescue* /boot/initramfs-*rescue* || { error_echo "Command failed: ls /boot/vmlinuz-*rescue* /boot/initramfs-*rescue*"; exit 1; }

    info_echo "Executing: lsinitrd /boot/initramfs-*rescue*.img | grep -qm1 "$(uname -r)/kernel/" && echo "OK" || echo "FAIL""
    lsinitrd /boot/initramfs-*rescue*.img | grep -qm1 "$(uname -r)/kernel/" && echo "OK" || echo "FAIL" || { error_echo "Command failed: lsinitrd /boot/initramfs-*rescue*.img | grep -qm1 "$(uname -r)/kernel/" && echo "OK" || echo "FAIL""; exit 1; }



# Step 14
step_echo 14 "Verify the rescue boot entry refers to the existing rescue files. See the grubby output:"
    # Verify the rescue boot entry refers to the existing rescue files. See the grubby output:
    # Check if grubby is installed
    if ! rpm -q grubby >/dev/null 2>&1; then
      info_echo "Installing required package: grubby"
      dnf install -y grubby || { error_echo "Failed to install grubby"; exit 1; }
    else
      info_echo "Package grubby is already installed"
    fi
    info_echo "Executing: grubby --info $(ls /boot/vmlinuz-*rescue*)"
    grubby --info $(ls /boot/vmlinuz-*rescue*) || { error_echo "Command failed: grubby --info $(ls /boot/vmlinuz-*rescue*)"; exit 1; }



#==============================================================================
# CHANGING SELINUX MODE TO ENFORCING
#==============================================================================
echo -e "\n${CYAN}Starting: Changing SELinux mode to enforcing${NC}\n"

# Step 15
step_echo 15 "[object Object]"
    # Ensure that there are no SELinux denials, for example, by using the  ausearch  utility:
    # Check if audit is installed
    if ! rpm -q audit >/dev/null 2>&1; then
      info_echo "Installing required package: audit"
      dnf install -y audit || { error_echo "Failed to install audit"; exit 1; }
    else
      info_echo "Package audit is already installed"
    fi
    info_echo "Executing: ausearch -m AVC,USER_AVC -ts boot"
    ausearch -m AVC,USER_AVC -ts boot || { error_echo "Command failed: ausearch -m AVC,USER_AVC -ts boot"; exit 1; }



# Step 16
step_echo 16 "[object Object]"
    # Changing SELinux mode to enforcing in   /etc/selinux/config
    info_echo "Executing: vi /etc/selinux/config"
    vi /etc/selinux/config || { error_echo "Command failed: vi /etc/selinux/config"; exit 1; }



# Step 17
step_echo 17 "Verify SELinux mode"
    # Verify SELinux mode
    info_echo "Executing: $ getenforce"
    $ getenforce || { error_echo "Command failed: $ getenforce"; exit 1; }

    info_echo "Executing: Enforcing"
    Enforcing || { error_echo "Command failed: Enforcing"; exit 1; }



#==============================================================================
# POST-UPGRADE CLEANUP COMPLETED
#==============================================================================

success_echo "Post-upgrade cleanup completed successfully!"
echo ""
echo -e "${BOLD}${GREEN}🎉 UPGRADE PROCESS COMPLETE! 🎉${NC}"
echo ""
echo -e "${BOLD}${YELLOW}FINAL VERIFICATION STEPS:${NC}"
echo -e "${CYAN}1.${NC} ${BOLD}Verify system functionality${NC} - Check that services are running"
echo -e "${CYAN}2.${NC} ${BOLD}Check application compatibility${NC} - Test your applications"
echo -e "${CYAN}3.${NC} ${BOLD}Update security policies${NC} if needed"
echo -e "${CYAN}4.${NC} ${BOLD}Test critical services${NC} - Ensure everything works as expected"
echo ""
echo -e "${GREEN}${BOLD}✅ Congratulations!${NC} Your RHEL upgrade is now complete."
echo ""
