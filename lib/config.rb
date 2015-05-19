# -*- mode: ruby -*-
# # vi: set ft=ruby :

# Configuration file location
CONFIG = File.join(File.dirname(__FILE__), "../config.rb")

# Auto-generated inventory used by vagrant
VAGRANT_INVENTORY = ".vagrant/provisioners/ansible/inventory"

# Ansible base constants
ANSIBLE_HOME          = ".ansible"
ANSIBLE_PYVENV        = "#{ANSIBLE_HOME}/pyvenv"
ANSIBLE_PYVENV_PREFIX = "#{ANSIBLE_PYVENV}/bin"
ANSIBLE_VERSION       = "1.9.0.1"

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
$ansible_bin          = "#{ANSIBLE_PYVENV_PREFIX}/ansible"
$ansible_playbook_bin = "#{ANSIBLE_PYVENV_PREFIX}/ansible-playbook"
$ansible_galaxy_bin   = "#{ANSIBLE_PYVENV_PREFIX}/ansible-galaxy"

# Import configuration file (if any)
if File.exist?(CONFIG)
  require CONFIG
end
