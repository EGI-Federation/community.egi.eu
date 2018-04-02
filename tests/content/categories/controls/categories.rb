# encoding: utf-8
# copyright: 2018, The Authors

title 'categories'
#params = yaml(content: inspec.profile.file('files/server.yml')).params

control 'category list' do
    title 'Seed Categories'
    desc 'Seed the categories with predetermined structure'
    tag 'http'
    # describe http("#{params['base_url']}#{['categories_url']}") do
    describe http('https://community.egi.eu/categories.json', method: 'GET') do
        its('status') { should cmp 200 }
        its('body') { should be }
        its('body') { should include 'category_list'}
        its('body') { should include 'Site Feedback'}
    end
end