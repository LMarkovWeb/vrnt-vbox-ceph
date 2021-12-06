#!/bin/bash



cat <<EOF
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

# Настройка SSH

# так же добавить и для клиента
#ssh-copy-id client


# Step 5 - Build the Ceph Cluster

# su - cephuser

# sudo rpm -Uhv http://download.ceph.com/rpm-jewel/el7/noarch/ceph-release-1-1.el7.noarch.rpm
# sudo yum install ceph-deploy -y

# mkdir cluster && cd cluster/

# ceph-deploy new mon1

# vim ceph.conf

# public network = 10.0.15.0/24
# osd pool default size = 2

# # Install Ceph on All Nodes
# ceph-deploy install ceph-admin mon1 osd1 osd2 osd3

# ceph-deploy mon create-initial

# ceph-deploy gatherkeys mon1

# # Adding OSDS to the Cluster
# ceph-deploy disk zap osd1:/dev/sdb osd2:/dev/sdb osd3:/dev/sdb
# ceph-deploy osd prepare osd1:/dev/sdb osd2:/dev/sdb osd3:/dev/sdb
# ceph-deploy osd activate osd1:/dev/sdb1 osd2:/dev/sdb1 osd3:/dev/sdb1
# ceph-deploy disk list osd1 osd2 osd3

# # Deploy the management-key to all associated nodes
# ceph-deploy admin cephadmin mon1 osd1 osd2 osd3