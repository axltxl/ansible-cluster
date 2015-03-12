# -*- mode: ruby -*-
# # vi: set ft=ruby :

require 'fileutils'

CONFIG = File.join(File.dirname(__FILE__), "config.rb")

# Defaults for config options defined in CONFIG
$num_instances = 1
$instance_name_prefix = "ansible"
$vm_gui = false
$vm_memory = 1024
$vm_cpus = 1
$vm_box = "centos-6/amd64"

#
$vm_boxes = {
  "ubuntu/trusty64" => "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box",
  "centos-6/amd64"  => "http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.4-x86_64-v20131103.box"
}

#
if File.exist?(CONFIG)
  puts "Merging configuration with #{CONFIG}"
  require CONFIG
end

Vagrant.configure("2") do |config|

  config.vm.provider "virtualbox"
  config.vm.box = $vm_boxes["#{$vm_box}"]



  #
  (1..$num_instances).each do |i|
    #
    config.vm.hostname = "#{$instance_name_prefix}-%02d" % i

    #
    config.vm.provider :virtualbox do |vb|
      vb.gui    = $vm_gui
      vb.memory = $vm_memory
      vb.cpus   = $vm_cpus
    end

    # 
    ip = "172.17.8.#{i+100}"
    config.vm.network :private_network, ip: ip
  end
end