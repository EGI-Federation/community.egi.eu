#!/usr/bin/ruby
require 'discourse_api'
require 'awesome_print'
require 'json'
require 'yaml'

# path to where the json seeds are
seeds_path = '../files/forum_data/categories/'
client = DiscourseApi::Client.new('https://community.egi.eu')
secrets = YAML.load_file('../files/secrets.yml')
# seed_categories = JSON.parse(File.read('../files/forum-data/categories/categories.json'))
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
        print "#{category['name']} has children \n"
    end
end

# Get the seeds
seed_files = Dir.glob("#{seeds_path}/*.json")
ap seed_files