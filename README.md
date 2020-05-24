[![Build Status](https://travis-ci.org/EGI-Foundation/community.egi.eu.svg?branch=master)](https://travis-ci.org/EGI-Foundation/community.egi.eu) [![Maintainability](https://api.codeclimate.com/v1/badges/5f45caa8cebee239d58f/maintainability)](https://codeclimate.com/github/EGI-Foundation/community.egi.eu/maintainability)

# EGI Community Forum

This repository contains the code necessary to deliver the [EGI Community Forum](https://community.egi.eu). This is a web forum based on [discourse](http://discourse.org)

The repository is organised into :

  * [Ansible playbook](community.egi.eu.yml) and configuration data for deploying the forum.
  * [Scripts](scripts/) for setting up the categories and seed content (using the [Discourse API](http://docs.discourse.org/))
  * [Tests](#testing) for checking whether the setup complies with security, style and content policies.

## Deployment

Deployment starts from scratch and results in a seeded community discussion forum. Only an ssh connection is needed, preferably with a non-root user which has sudo rights on the forum host.
The host is in the `forum` group in the inventory file. Tasks applied to this group pick up variables from the `vars/community.egi.eu.yml` file, because that is how excellent Ansible is.

The playbook uses a single role - [AAROC.discourse-sso](https://github.com/AAROC/discourse-sso) however this role has dependencies. Before making or proposing changes to this role, please consider what the dependencies do to provide docker and nginx.

## Installing prerequisites

Various solutions are available to manage python and ruby virtual environments,
if you don't know what to use you can do the following to create them.

### Installing a python3 virtualenv and required packages

```sh
# Create a dedicated python3 virtualenv
python -m venv ~/.virtualenv/community
# Activate the python3 virtualenv manually if necessary
source ~/.virtualenv/community/bin/activate
# Install required python packages
pip install -r requirements.txt
# Install required ansible modules
ansible-galaxy install -r requirements.yml
```

### Installing a ruby virtualenv and required gems

```sh
# Install rvm
gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable
# Install a stable version of ruby
rvm list known
rvm install 2.7
# Create and activate a dedicated ruby virtualenv and gemset
rvm --ruby-version use 2.7.0@community --create
# Activate the ruby virtualenv manually if necessary
rvm use ruby-2.7.0@community
# Install required gems
gem install bundler:1.16.3
bundle install
```

## Continuous Delivery

If you are the maintainer of the service, you need to run the playbook with the right variables.

  1. Ensure that you have the roles locally :
    * `ansible-galaxy install -r requirements.yml`
  1. Ensure you have your vars set up in `vars/<forum_host_name>.yml`
  1. Ensure you have your secret vars set up in `files/secrets.yml` (see `files/secrets.yml.sample`)
  1. Check the validity of the certificate and private keys in `files/etc/ssl`
  1. Check the `inventory`.

If all that is ok, run the playbook, or get your favourite CI tool to do it :
```sh
ansible-playook forum.yml
```

## Testing

The [tests](tests/README.md) directory contains the tests that we expect the service, server and machine to pass.
They contain tests for the ssh connection, nginx server configuration and some content.

## Authors

See [the authors file](authors.yml)
