#!/bin/bash

THIS=`readlink -f "${BASH_SOURCE[0]}"`
DIR=`dirname "${THIS}"`

cd $DIR

echo "[TASK 1] Change root password"
sudo chpasswd <<<"root:root"

echo "[TASK 2] "
sudo echo '%sudo ALL=(ALL:ALL) NOPASSWD: ALL' | sudo EDITOR='tee -a' visudo
sudo sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config
sudo systemctl restart sshd.service

echo "[TASK 3] Update and install"
yum update
yum install htop mc vim -y

echo "[TASK 4] Create a cephuser"
sudo adduser cephuser
sudo chpasswd <<<'cephuser:cephuser'
echo "cephuser ALL = (root) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/cephuser
chmod 0440 /etc/sudoers.d/cephuser
sed -i s'/Defaults requiretty/#Defaults requiretty'/g /etc/sudoers

echo "[TASK 5] Disable SELinux"
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config

echo "[TASK 6] Update /etc/hosts file"
cat >>/etc/hosts<<EOF
10.0.15.10 cephadmin
10.0.15.11 mon1
10.0.15.21 osd1
10.0.15.22 osd2
10.0.15.23 osd3
10.0.15.15 client
EOF
