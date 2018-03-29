[![Build Status](https://travis-ci.org/EGI-Foundation/community.egi.eu.svg?branch=master)](https://travis-ci.org/EGI-Foundation/community.egi.eu)

# EGI Community Forum

This repository contains the code necessary to deliver the [EGI Commnuity Forum](https://community.egi.eu). This is a web forum based on [discourse](http://discourse.org)

The repository is organised into Ansible playbook and configuration data for deploying the forum. The host is in the `forum` group in the inventory file. Tasks applied to this group pick up variables from the `forum.yml` file in `group_vars`, because that is how excellent Ansible is. 

The playbook uses a single role - [AAROC.discourse-sso](https://github.com/AAROC/discourse-sso) however this role has dependencies. Before making or proposing changes to this role, please consider what the dependencies do to provide docker and nginx.

## Continuous Delivery

If you are the maintainer of the service, you need to run the playbook with the right variables.

  1. Ensure that you have the roles locally : `ansible-galaxy install AAROC.discourse-sso`
  1. Ensure you have your vars set up in `group_vars/forum.yml`
  1. Check the validity of the certificate and private keys in `files/etc/ssl`
  1. Check the inventory.

If all that is ok, run the playbook, or get your favourite CI tool to do it : 
`ansible-playook -i inventory community.egi.eu.yml`