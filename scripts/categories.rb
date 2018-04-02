#!/usr/bin/ruby
require 'discourse_api'
require 'awesome_print'
require 'json'
require 'yaml'
client = DiscourseApi::Client.new('https://community.egi.eu')
secrets = YAML.load_file('../files/secrets.yml')
client.api_key = secrets['api_key']
client.api_username = 'brucellino'
# Create an array that will hold the parent category ids
parent_categories = []

# Get all the categories - an array of hashes
categories = client.categories
categories.each do |category|
    if category['has_children']
        parent_categories.push(category['id'])
        # Get all the  categories with this parent_id
    else
        print "\n"
    end
end

ap parent_categories