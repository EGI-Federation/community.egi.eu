# Scripts

This directory contains utility scripts for the community forum deployment and batch
management activities.

While the Ansible playbook, roles and vars take care of putting up the basic in
## Categories

[`categories.rb`] is a Ruby script used to populate the forum with seed categories, in the case of deployment.
It uses JSON seeds contained in `files/categories/` and the [discourse API](https://docs.discourse.org) to do this.
An API key is necessary to use the discourse API - these can be generated at `/admin/api` if you have the correct permissions. If no, ask `@staff` to help you out.

### Executing the script

In order to execute the script, you need ruby (>2.3) in your environment
