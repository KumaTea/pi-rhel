#!/usr/bin/env bash

dnf update kernel-uek.aarch64
reboot

# https://www.redhat.com/en/blog/introduction-convert2rhel-now-officially-supported-convert-rhel-systems-rhel
curl -o /etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release https://www.redhat.com/security/data/fd431d51.txt
curl --create-dirs -o /etc/rhsm/ca/redhat-uep.pem https://ftp.redhat.com/redhat/convert2rhel/redhat-uep.pem
curl -o /etc/yum.repos.d/convert2rhel.repo https://ftp.redhat.com/redhat/convert2rhel/8/convert2rhel.repo
dnf install convert2rhel -y

cp /usr/share/convert2rhel/configs/oracle-8-x86_64.cfg /usr/share/convert2rhel/configs/oracle-8-aarch64.cfg
sed -i 's/rhel-8-for-x86_64/rhel-8-for-aarch64/g' /usr/share/convert2rhel/configs/oracle-8-aarch64.cfg
# sed -i 's/-rpms/-beta-rpms/g' /usr/share/convert2rhel/configs/oracle-8-aarch64.cfg
# sed -i "s/checks.perform_pre_checks()/loggerinst.task('SKIP CHECKS')  # checks.perform_pre_checks()/g" /usr/lib/python3.6/site-packages/convert2rhel/main.py
sed -i 's/json-c.x86_64/json-c.aarch64/g' /usr/lib/python3.6/site-packages/convert2rhel/subscription.py

source /etc/os-release && python3 -c "from convert2rhel import main, subscription, systeminfo; main.initialize_logger('convert2rhel.log', '/var/log/convert2rhel'); systeminfo.RELEASE_VER_MAPPING['$VERSION'] = '$VERSION'; systeminfo.system_info.resolve_system_info(); subscription.download_rhsm_pkgs()"
cd /usr/share/convert2rhel/subscription-manager
dnf install -y $(ls | tr '\n' ' ')
cd ~


# https://access.redhat.com/solutions/6029971
# https://access.redhat.com/labs/rhpc/
bash crt/Red_Hat_Product_Certificates.sh
subscription-manager register
subscription-manager list --available
# subscription-manager attach --pool=<pool>

dnf clean all
mv /etc/yum.repos.d/convert2rhel.repo /etc/yum.repos.d/convert2rhel.repo.bak
mv /etc/yum.repos.d/oracle-linux-ol8.repo /etc/yum.repos.d/oracle-linux-ol8.repo.bak

dnf install nano wget curl tar parted ca-certificates -y

# parted
# resizepart 3
# 100
parted --script /dev/sda \
    resizepart 3 100%
btrfs filesystem resize max /


dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
subscription-manager repos --enable "codeready-builder-for-rhel-8-$(arch)-rpms"
dnf remove convert2rhel -y
cd /usr/share/convert2rhel/subscription-manager
dnf reinstall -y $(ls | tr '\n' ' ' | sed 's/.rpm//g')
cd ~
rm -rvf /usr/share/convert2rhel

# echo "max_parallel_downloads = 16" >> /etc/dnf/dnf.conf
echo "max_parallel_downloads = 16" >> /etc/yum.conf

# dnf install sudo fish htop neofetch
dnf install redhat-lsb -y

dnf remove oraclelinux-release oraclelinux-release-el8 || rpm -e --nodeps oraclelinux-release oraclelinux-release-el8
dnf reinstall setup

dnf distro-sync
dnf update -y
dnf reinstall $(dnf list --installed | grep ol8 | awk '{print $1}' | tr '\n' ' ')
dnf reinstall $(dnf list --installed | grep anaconda | awk '{print $1}' | tr '\n' ' ')
dnf reinstall $(dnf list --installed | grep commandline | awk '{print $1}' | tr '\n' ' ')

# subscription-manager release --set=8.6
dnf update


###### UPGRADE ######

# subscription-manager release --set 8.6
# dnf update

# dnf install leapp-upgrade

# leapp preupgrade --target 9.0
# leapp upgrade --target 9.0
