# -*- mode: ruby -*-
# vi: set ft=ruby :

# Version control-related variables
require File.join(File.dirname(__FILE__), "lib/git.rb")

# Configuration file
require File.join(File.dirname(__FILE__), "lib/config.rb")

if File.exist?(CONFIG)
  require CONFIG
end

# git branch as an ansible environment
# Ansible hosts group to which these rake tasks are going to target to
ANSIBLE_STAGE=Git::BRANCH

##################################
# Utility functions
###################################

def ansible_playbook(inventory, args="")
  verbosity = $ansible_verbose.empty? ? "" : "-#{$ansible_verbose}"
  sh %{#{$ansible_playbook_bin} #{$ansible_playbook} #{verbosity} } \
   + %{-i #{inventory} #{args} --limit=#{ANSIBLE_STAGE}}
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
  sh %{#{$ansible_galaxy_bin} install -r requirements.txt}
end

desc "Install ansible"
task :install_ansible do
  ansible_pyvenv_install ANSIBLE_PYVENV
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
