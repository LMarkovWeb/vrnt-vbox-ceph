#!/bin/bash

USER=cephuser
DIR=/home/$USER
GROUP=cephuser

echo "[TAKS 1] Check the partition with the fdisk command"
fdisk -l /dev/sdb

echo "[TAKS 2] Format the /dev/sdb partition with XFS filesystem and with a GPT partition table"
sudo parted -s /dev/sdb mklabel gpt mkpart primary xfs 0% 100%
sudo mkfs.xfs /dev/sdb -f

echo "[TAKS 3]"
chown $USER:$GROUP -R $DIR
chmod 755 $DIR
chmod 700 $DIR/.ssh
chmod 600 $DIR/.ssh/authorized_keys