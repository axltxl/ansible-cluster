# -*- mode: ruby -*-
# # vi: set ft=ruby :

# Module imports
require 'fileutils'

# Configuration file location
CONFIG = File.join(File.dirname(__FILE__), "config.rb")

# Defaults for config options defined in CONFIG
$num_instances    = 1
$vm_gui           = false
$vm_memory        = 1024
$vm_cpus          = 1
$vm_box           = "ubuntu/trusty64"
$ansible_playbook = "site.yml"
$ansible_verbose  = ""

# Available vagrant boxes
$vm_boxes = {
  "ubuntu/trusty64"     => "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box",
  "centos-6.5-amd64"    => "http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.4-x86_64-v20131103.box",
  "coreos-stable"       => "http://stable.release.core-os.net/amd64-usr/current/coreos_production_vagrant.json"
}

# This is the prefix used in hostnames
# for each vagrant boxcarav
INSTANCE_NAME_PREFIX = "ship"

# Import configuration file (if any)
if File.exist?(CONFIG)
  puts "Merging configuration with #{CONFIG}"
  require CONFIG
end

puts "Current configuration:"
puts "----------------------"
puts "num_instances    = #{$num_instances}"
puts "vm_gui           = #{$vm_gui}"
puts "vm_cpus          = #{$vm_cpus}"
puts "vm_box           = #{$vm_box}"
puts "ansible_playbook = #{$ansible_playbook}"
puts "----------------------"

# Now, the real magic begins ...
Vagrant.configure("2") do |config|

  config.vm.provider "virtualbox"
  config.vm.box = $vm_box
  config.vm.box_version = ">= 308.0.1" if $vm_box == "coreos-stable"
  config.vm.box_url = $vm_boxes["#{$vm_box}"]
  config.vm.box_check_update = true

 #
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = $ansible_playbook
    ansible.groups = {
      "cluster-nodes" => [ "#{INSTANCE_NAME_PREFIX}-[%02d:%02d]" % [0,99] ]
    }
    ansible.sudo    = true
    ansible.verbose = $ansible_verbose
  end

  # We're gonna create a number of machines with the same
  # settings each
  (1..$num_instances).each do |i|

    #
    config.vm.define vm_name = "%s-%02d" % [INSTANCE_NAME_PREFIX, i] do |config|
      config.vm.hostname = vm_name
      # Provider options
      # virtualbox
      config.vm.provider :virtualbox do |vb|
        vb.gui    = $vm_gui
        vb.memory = $vm_memory
        vb.cpus   = $vm_cpus
      end

      # Set up private IP
      ip = "172.17.8.#{i+100}"
      config.vm.network :private_network, ip: ip
    end
  end
end
