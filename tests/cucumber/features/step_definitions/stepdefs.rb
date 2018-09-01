require 'watir'
require "rspec/expectations"
Given(/I visit the main page/) do
  @browser = Watir::Browser.new :firefox
  @browser.goto 'https://community.egi.eu'
end

When(/I look for the login button/) do
  @login_button = @browser.button(class: /login-button/)  
end

Then(/it is present/) do
  @login_button.exists?
end
