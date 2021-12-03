# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV['VAGRANT_NO_PARALLEL'] = 'yes'
ENV['VAGRANT_EXPERIMENTAL'] = 'disks'

Vagrant.configure(2) do |config|

  config.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/me.pub"
  config.vm.provision "shell", inline: <<-SHELL
    cat /home/vagrant/.ssh/me.pub >> /home/vagrant/.ssh/authorized_keys
  SHELL

  config.vm.provision "shell", path: "scripts/bootstrap.sh"

  # NodeCount = 3

  # # OSD nodes
  # (1..NodeCount).each do |i|
  #   config.vm.define "ceph_osd#{i}" do |osd|
  #     osd.vm.box = "centos/7"
  #     osd.vm.hostname = "osd#{i}.local"
  #     osd.vm.network "private_network", ip: "10.0.15.2#{i}"
  #     osd.vm.disk :disk, name: "main", primary: 'yes', size: "10GB"
  #     osd.vm.disk :disk, name: "data", size: "20GB"

  #     osd.vm.provider "virtualbox" do |v|
  #       v.name = "ceph_osd_#{i}"
  #       v.memory = 2048
  #       v.cpus = 2
  #       v.gui = false
  #     end
  #   end
  # end

  # # Ceph Admin
  # config.vm.define "cephdmin" do |cephdmin|
  #   cephdmin.vm.box = "centos/7"
  #   cephdmin.vm.hostname = "cephadmin.local"
  #   cephdmin.vm.network "private_network", ip: "10.0.15.10"
  #   cephdmin.vm.disk :disk, name: "main", primary: 'yes', size: "10GB"

  #   cephdmin.vm.provider "virtualbox" do |v|
  #     v.name = "cephdmin"
  #     v.memory = 2048
  #     v.cpus = 2
  #     v.gui = false
  #   end
  # end
  
  # Ceph MON
  config.vm.define "mon" do |mon|
    mon.vm.box = "centos/7"
    mon.vm.hostname = "cephmon.local"
    mon.vm.network "private_network", ip: "10.0.15.11"
    mon.vm.disk :disk, name: "main", primary: 'yes', size: "10GB"

    mon.vm.provider "virtualbox" do |v|
      v.name = "cephmon"
      v.memory = 2048
      v.cpus = 2
      v.gui = false
    end
  end
  

end
