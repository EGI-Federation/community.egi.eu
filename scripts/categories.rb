#!/usr/bin/ruby
require 'discourse_api'
require 'awesome_print'
require 'json'
require 'yaml'

# path to where the json seeds are
seeds_path = '../files/forum-data/categories/'
forum_client = DiscourseApi::Client.new('https://community.egi.eu')
secrets = YAML.load_file('../files/secrets.yml')
# seed_categories = JSON.parse(File.read('../files/forum-data/categories/categories.json'))
forum_client.api_key = secrets['api_key']
forum_client.api_username = 'brucellino'
# Create an array that will hold the parent category ids
parent_categories = []

# Get all the categories - an array of hashes
categories = forum_client.categories
categories.each do |category|
    if category['has_children']
        parent_categories.push(category['id'])
        # Get all the  categories with this parent_id
        print "#{category['name']} has children \n"
    end
end

# Get the seeds
Dir.glob("#{seeds_path}/*.yml").each do |file|
    new_category = YAML.load_file(file)
    new_category.each do |category|
        print category['name'] + "\n"
        args = {
                        name: category['name'], 
                        color: category['color'],
                        text_color: category['text_color'],
                        description: category['description'],
                        # permissions: category['permissions'],
                        slug: category['slug'],
                        parent_category_id: category['parent_category_id']
        }
        begin
            forum_client.create_category(args)
        rescue => exception
            puts "Exception #{exception}"
        else
            puts "added a category"
        end
    end
end

