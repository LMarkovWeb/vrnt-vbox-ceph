#!/bin/bash

USER=cephuser
DIR=/home/$USER
GROUP=cephuser

echo "[TAKS 1]"
chown $USER:$GROUP -R $DIR
chmod 755 $DIR
chmod 700 $DIR/.ssh
chmod 600 $DIR/.ssh/authorized_keys


