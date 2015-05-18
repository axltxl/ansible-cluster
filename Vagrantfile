# -*- mode: ruby -*-
# # vi: set ft=ruby :

# Module imports
require 'fileutils'

# Version control-related variables
require File.join(File.dirname(__FILE__), "lib/git.rb")

# Configuration file
require File.join(File.dirname(__FILE__), "lib/config.rb")

# This is the prefix used in hostnames
# for each vagrant boxcarav
INSTANCE_NAME_PREFIX = "ship"

# Whether or not to show current configuration
$show_config = false

if $show_config then
  puts "Current configuration:"
  puts "----------------------"
  puts "num_instances    = #{$num_instances}"
  puts "vm_box           = #{$vm_box}"
  puts "vm_box_url       = #{$vm_box_url}"
  puts "vm_gui           = #{$vm_gui}"
  puts "vm_cpus          = #{$vm_cpus}"
  puts "vm_memory        = #{$vm_memory}"
  puts "ansible_playbook = #{$ansible_playbook}"
  puts "----------------------"
end

# Now, the real magic begins ...
Vagrant.configure("2") do |config|

  config.vm.provider "virtualbox"
  config.vm.box              = $vm_box
  config.vm.box_version      = $vm_box_version if $vm_box_version != nil
  config.vm.box_url          = $vm_box_url
  config.vm.box_check_update = $vm_box_check_update

  # Ansible host group
  ansible_hosts = []

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
    # Add this host to the ansible inventory
    ansible_hosts.push(vm_name)
  end

  # Ansible provider configuration
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = $ansible_playbook
    ansible.groups = {
      Git::BRANCH => ansible_hosts
    }
    ansible.sudo    = true
    ansible.verbose = $ansible_verbose
  end

end
