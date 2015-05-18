#Ansible playbooks
This is a set of ansible playbooks and roles which can be developed and tested via vagrant and are meant to be used for provisioning nodes accross an inventory. 

##Requirements
* python >= 2.7 < 3
* ruby
* ansible
* vagrant
* rake

## Set up

```bash
# Get necessary packages
apt-get install vagrant #it's best to get the deb package directly from vagrantup.com
gem install rake
pip install ansible
```

## *Stage environment* configuration
Through many variables, things can be done differently using `vagrant` and `ansible` via `rake`.  These variables can be held inside a configuration file named `config.rb`. You can start by copying this repo's `config.rb.sample` and read its instructions to get an idea of what you can do to tweak your *stage environment*.

#### Current git branch as the *stage environment*
A git-based approach has been implemented for a multi-stage `ansible` codebase. Instead of using a complex directory layout to separate things among hosts groups in `ansible`, the name of the current `git` branch is used by `rake` to determine what hosts are going to be targeted by `ansible-playbook`. Therefore, the name of the current `git` branch is treated as an expected target host group inside your `$ansible_inventory`.  

In this way, there can be a guaranteed separated playbook development to make sure different environments can be developed using different role versions without compromising its siblings,  most importantly, deployments can be made on the right hosts comfortably (no room for accidents).

## `rake` Tasks

All necessary operations for development/deployments are done through `rake` tasks

### Install third-party dependencies

First of all, you will need to fulfill the requirements of this environment
```bash
# Once you have cloned this repo, you need to set up dependencies such as ansible roles, etc.
rake install
```

If you only want to install/reinstall ansible roles you can execute `rake install_roles` 

### List boxes that are going to be provisioned by ansible
```bash
# This will list vagrant boxes only
rake vagrant:list

# This will use your $ansible_inventory in config.rb
# You can use this approach to list hosts outside your vagrant environment
rake list
```

### Test your `$ansible_playbook` with your Vagrant boxes
```bash
# this will bring your vagrant box(es) up and provision them 
# with your $ansible_playbook
rake vagrant:test
```

### Deploy your changes on your *stage environment*

```bash
# This will provision your hosts set in your $ansible_inventory using your $ansible_playbook
rake deploy 
```

##Copyright and Licensing
Copyright (c) 2015 Alejandro Ricoveri

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.