# -*- mode: ruby -*-
# # vi: set ft=ruby :

# Configuration file location
CONFIG = File.join(File.dirname(__FILE__), "../config.rb")

# Auto-generated inventory used by vagrant
VAGRANT_INVENTORY = ".vagrant/provisioners/ansible/inventory"

# Defaults for config options defined in CONFIG
$num_instances       = 1
$vm_gui              = false
$vm_memory           = 1024
$vm_cpus             = 1
$vm_box_check_update = true

# Defaults for ansible
$ansible_playbook  = "site.yml"
$ansible_verbose   = ""
$ansible_inventory = "inventory"

# ansible binaries
$ansible_bin          = "ansible"
$ansible_playbook_bin = "ansible-playbook"
$ansible_galaxy_bin   = "ansible-galaxy"

# Import configuration file (if any)
if File.exist?(CONFIG)
  require CONFIG
end
