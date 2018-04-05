# encoding: utf-8
# copyright: 2018, The Authors
title 'categories'
data = yaml(content: inspec.profile.file('categories.yml')).params
    
control 'category list' do
    title 'Seed Categories'
    desc 'Seed the categories with predetermined structure'
    tag 'http'
    
    describe http('https://community.egi.eu/categories.json', method: 'GET') do
        its('status') { should cmp 200 }
        its('body') { should be }
        its('body') { should include 'category_list'}
        data['categories'].each do |category|
            its('body') { should include category['name'] }
            its('body') { should include category['slug']}
        end
    end
end