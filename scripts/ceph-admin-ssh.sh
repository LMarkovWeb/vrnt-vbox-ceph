#!/bin/bash

USER=cephuser
DIR=/home/$USER
GROUP=cephuser
CEPH_HOSTS="osd1 osd2 osd3 mon1 client"

cat > $DIR/.ssh/config << EOF
Host ceph-admin
  Hostname ceph-admin
  User cephuser
Host mon1
  Hostname mon1
  User cephuser
Host osd1
  Hostname osd1
  User cephuser
Host osd2
  Hostname osd2
  User cephuser
Host osd3
  Hostname osd3
  User cephuser
Host client
  Hostname client
  User cephuser
EOF

ssh-keyscan $CEPH_HOSTS >> $DIR/.ssh/known_hosts

chown $USER:$GROUP -R $DIR
chmod 755 $DIR
chmod 700 $DIR/.ssh
chmod 644 $DIR/.ssh/config 
chmod 644 $DIR/.ssh/id_rsa.pub
chmod 600 $DIR/.ssh/id_rsa
