#Ansible playbooks
This is a set of ansible playbooks composed by a set of roles meant to be used for provisioning groups of nodes across an infrastructure.

##Requirements
* python
* ruby
* ansible
* vagrant

## Set up

```bash
# Get vagrant and ansible
gem install vagrant
pip install ansible

# Install third-party dependencies
ansible-galaxy install -r requirements.txt
```

## Vagrant environment configuration
You can optionally copy `config.rb.sample` to `config.rb` in order to tweak the Vagrant environment. 
See `config.rb.sample` for further instructions.

## Test the environment

```bash
vagrant up
```

## Types of nodes

###coreos
This host group hold tasks for pre-provisioning CoreOS hosts [EXPERIMENTAL]

### cluster-nodes
The `cluster-nodes` are mostly dummies that once provisioned they should be ready to hold Docker containers and belong to a cluster.