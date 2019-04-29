# copyright: 2018, The Authors

# encoding: UTF-8

require 'discourse_api'
require 'awesome_print'
require 'json'
require 'yaml'

# path to where the json seeds are
seeds_path = '../files/forum-data/categories/'
forum_client = DiscourseApi::Client.new('https://community.egi.eu')
secrets = YAML.load_file('../files/secrets.yml')
forum_client.api_key = secrets['api_key']
forum_client.api_username = secrets['api_username']
# Create an array that will hold the parent category ids
parent_categories = []

# Get all the categories - an array of hashes
categories = forum_client.categories
categories.each do |category|
  parent_categories.push(category['id']) unless category['has_children'].nil?
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
    rescue StandardError => exception
      puts "Exception #{exception}"
    end
    puts 'added a category'
  end
end
