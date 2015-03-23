#Ansible cluster
This is a set of ansible playbooks composed by a set of roles meant to be used for provisioning all nodes across a cluster, these nodes are mostly dummies that once provisioned they should be ready to hold Docker containers and belong to a cluster.

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
[coming soon]

## Release The Kraken!

```bash
vagrant up
```
