# -*- mode: ruby -*-
# vi: set ft=ruby :

# Configuration library
require File.join(File.dirname(__FILE__), "lib/config.rb")

###################################
# Set EC2_INIT_PATH to ec2.ini which is used by the dynamic
# inventory located at inventory/ec2.py
###################################
ENV['EC2_INI_PATH'] = File.join(File.dirname(__FILE__), "ec2.ini")

##################################
# Utility functions
###################################

def ansible_playbook(inventory, args="")
  verbosity = $ansible_verbose.empty? ? "" : "-#{$ansible_verbose}"
  sh %{#{$ansible_playbook_bin} #{$ansible_playbook} #{verbosity} } \
   + %{-i #{inventory} #{args} --extra-vars="environment=#{ANSIBLE_STAGE}"}
end

def ansible_playbook_vagrant(args="")
  ansible_playbook(VAGRANT_INVENTORY, args)
end

def ansible_pyvenv_sh(cmd)
  sh %{#{ANSIBLE_PYVENV_PREFIX}/#{cmd}}
end

def ansible_pyvenv_install(ansible_pyenv)
  rm_rf ansible_pyenv
  mkdir_p ansible_pyenv
  sh %{virtualenv #{ansible_pyenv}}
  ansible_pyvenv_sh "pip install ansible==#{ANSIBLE_VERSION}"
end

##################################
# Tasks
##################################

desc "Install ansible roles"
task :install_roles => :install_ansible do
  rm_rf 'dist'
  sh %{#{$ansible_galaxy_bin} install -r requirements.yml}
end

desc "Install all dependencies"
task :install => :install_roles

namespace :vagrant do
  desc "List current hosts in the inventory"
  task :list do
    ansible_playbook_vagrant "--list-hosts"
  end

  desc "Get the vagrant boxes up"
  task :up do
    sh %{vagrant up --no-provision}
  end

  task :destroy do
    sh %{vagrant destroy -f}
  end

  desc "Provision vagrant boxes with the ansible playbook"
  task :test => 'vagrant:up' do
    sh %{vagrant provision}
  end
end

desc "List all hosts within the inventory (limited to stage)"
task :list do
  ansible_playbook $ansible_inventory, "--list-hosts"
end

desc "Deploy your playbook onto your stage environment"
task :deploy do
  ansible_playbook $ansible_inventory
end
