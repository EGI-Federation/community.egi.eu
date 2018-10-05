require "watir"
require "rspec/expectations"
require 'cucumber/rspec/doubles'

Given('I am a test user') do
  @username = ENV['USER_NAME']
  @password = ENV['USER_PASSWORD']
end

Given('I am on the main page') do
  @browser = Watir::Browser.new :firefox
  @browser.goto 'https://community.egi.eu'
end

Given("I visit the main page") do
  @browser.goto 'https://community.egi.eu/'
  expect(@browser.title).to match( /EGI Foundation/ )
end

When("I look for the login button") do
  @login_button = @browser.button(visible_text: /log in/i)
end

Then("it is present") do
  expect(@login_button).to  exist
  expect(@login_button.text).to match(/log in/i)
end

Given("I click on the login button") do
  @login_button = @browser.button(visible_text: /log in/i)
  @login_button.click
end

Then("I am taken to EGI AAI") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("I choose SSO") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("I add my credentials") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("I am asked to release my attributes") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("I am taken back to the main forum") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("I can see my profile information") do
  pending # Write code here that turns the phrase above into concrete actions
end


After do
  @browser.close
end
