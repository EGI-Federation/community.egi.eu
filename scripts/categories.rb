#!/usr/bin/ruby
require 'discourse_api'
require 'awesome_print'
require 'json'
client = DiscourseApi::Client.new('https://community.egi.eu')
client.api_key = '9c605277dc71e039a27efe00670ec3bb8f507564cdec4343069e7da9e09ccccc'
client.api_username = 'brucellino'

#client.ssl(...)                                 #=> specify SSL connection settings if needed

# Topic endpoints
# ap client.latest_topics                            #=> Gets a list of the latest topics

# ap client.new_topics                               #=> Gets a list of new topics
# ap client.topics_by("brucellino")                         #=> Gets a list of topics created by user "sam"
#client.topic(57)                                #=> Gets the topic with id 57

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