# Scripts Readme

Utility scripts for the community forum deployment

## Categories

[`categories.rb`] is a Ruby script to populate the forum with seed categories, in the case of deployment.
It uses JSON seeds contained in `files/categories/` and the [discourse API](https://docs.discourse.org) to do this.
An API key is necessary to use the discourse API - these can be generated at `/admin/api` if you have the correct permissions. If no, ask `@staff` to help you out.

### Executing the script

