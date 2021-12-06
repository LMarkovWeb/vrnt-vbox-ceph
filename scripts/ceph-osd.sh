#!/bin/bash

echo "[TAKS 1] Check the partition with the fdisk command"
fdisk -l /dev/sdb

echo "[TAKS 2] Format the /dev/sdb partition with XFS filesystem and with a GPT partition table"
sudo parted -s /dev/sdb mklabel gpt mkpart primary xfs 0% 100%
sudo mkfs.xfs /dev/sdb -f