# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV['VAGRANT_NO_PARALLEL'] = 'yes'
ENV['VAGRANT_EXPERIMENTAL'] = 'disks'

Vagrant.configure(2) do |config|

  # keys
  config.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/me.pub"
  config.vm.provision "shell", inline: <<-SHELL
    cat /home/vagrant/.ssh/me.pub >> /home/vagrant/.ssh/authorized_keys
  SHELL

  # shell
  config.vm.provision "shell", path: "scripts/bootstrap.sh"
  config.vm.provision "file", source: "cephuser_keys/authorized_keys", destination: "~/.ssh/authKeys"
  config.vm.provision "shell", inline: <<-SHELL
    cat /home/vagrant/.ssh/authKeys >> /home/cephuser/.ssh/authorized_keys
  SHELL

  NodeCount = 3

  # OSD nodes
  (1..NodeCount).each do |i|
    config.vm.define "cephosd#{i}" do |osd|
      osd.vm.box = "centos/7"
      osd.vm.hostname = "osd#{i}"
      osd.vm.network "private_network", ip: "10.0.15.2#{i}"
      osd.vm.disk :disk, size: "5GB", name: "data"
      osd.vm.provider "virtualbox" do |v|
        v.name = "cephosd#{i}"
        v.memory = 2048
        v.cpus = 2
        v.gui = false
      end
      #shell
      osd.vm.provision "shell", path: "scripts/ceph-osd.sh"
    end
  end

  # Ceph MON
  config.vm.define "mon" do |mon|
    mon.vm.box = "centos/7"
    mon.vm.hostname = "mon1"
    mon.vm.network "private_network", ip: "10.0.15.11"
    mon.vm.provider "virtualbox" do |v|
      v.name = "cephmon"
      v.memory = 2048
      v.cpus = 2
      v.gui = false
    end
    #shell
    mon.vm.provision "shell", path: "scripts/ceph-mon.sh"
  end

  # Ceph client
  config.vm.define "client" do |client|
    client.vm.box = "centos/7"
    client.vm.hostname = "client"
    client.vm.network "private_network", ip: "10.0.15.15"
    client.vm.provider "virtualbox" do |v|
      v.name = "cephclient"
      v.memory = 2048
      v.cpus = 2
      v.gui = false
    end
    #shell
    client.vm.provision "shell", path: "scripts/ceph-client.sh"
  end

  # Ceph Admin. The admin node is used for installing and configuring all cluster nodes
  config.vm.define "cephadmin" do |cephadmin|
    cephadmin.vm.box = "centos/7"
    cephadmin.vm.hostname = "cephadmin"
    cephadmin.vm.network "private_network", ip: "10.0.15.10"
    cephadmin.vm.provider "virtualbox" do |v|
      v.name = "cephadmin"
      v.memory = 2048
      v.cpus = 2
      v.gui = false
    end
    # shell
    cephadmin.vm.provision "file", source: "cephuser_keys/id_rsa.pub", destination: "~/.ssh/cephuser_id_rsa.pub"
    cephadmin.vm.provision "file", source: "cephuser_keys/id_rsa", destination: "~/.ssh/cephuser_id_rsa"
    cephadmin.vm.provision "shell", inline: <<-SHELL
      cat /home/vagrant/.ssh/cephuser_id_rsa.pub > /home/cephuser/.ssh/id_rsa.pub
      cat /home/vagrant/.ssh/cephuser_id_rsa > /home/cephuser/.ssh/id_rsa
    SHELL
    cephadmin.vm.provision "shell", path: "scripts/ceph-admin-ssh.sh"
  end
  
end
