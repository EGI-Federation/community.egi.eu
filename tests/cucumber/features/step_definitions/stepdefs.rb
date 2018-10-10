require 'watir'
require 'rspec/expectations'
require 'cucumber/rspec/doubles'
require 'json'

Watir.default_timeout = 10

Given('I am a test user') do
  @username = ENV['USER_NAME']
  expect(@username).to be
  @password = ENV['USER_PASSWORD']
  expect(@password).to be
end

Given('I am on the main page') do
  @browser = Watir::Browser.new :firefox
  @browser.goto 'https://community.egi.eu'
  # load_secs = @browser.performance.summary[:response_time] / 1000
  # expect(load_secs).to < 300
end

Given('I visit the main page') do
  @browser.goto 'https://community.egi.eu/'
  expect(@browser.title).to match(/EGI Foundation/)
end

When('I look for the login button') do
  @login_button = @browser.button(visible_text: /log in/i)
end

Then('it is present') do
  expect(@login_button).to exist
  expect(@login_button.text).to match(/log in/i)
end

Given('I click on the login button') do
  @login_button = @browser.button(visible_text: /log in/i)
  @login_button.click
end

Then('I am taken to EGI Check-In IdP discovery page') do
  @browser.window(title: /identity provider/i).use
end

Then('I choose SSO') do
  @browser.text_field(placeholder: /Search/).wait_until(&:present?)
  @browser.div(id: 'loader').wait_while(&:present?)
  @browser.text_field(placeholder: /Search/).set 'EGI SSO'
  @egi_sso = @browser
             .link(text: 'EGI SSO',
                   style: /display: block;/)
             .wait_until_present
  expect(@egi_sso).to be_present
  @egi_sso.click
end

Then('I add my credentials') do
  @browser.window(title: 'EGI SSO Identity Provider').use
  expect(@browser.text_field(id: 'username')).to exist
  expect(@browser.text_field(id: 'password')).to exist
  @browser.text_field(id: 'username', name: 'j_username').set @username.to_s
  @browser.text_field(id: 'password').set @password.to_s
  @browser.button(visible_text: /login/i).click
end

Then('I am asked to release my attributes') do
  @browser.window(title: 'Information Release').use
  expect(@browser.span(class: 'service_name')).to exist
  expect(@browser.span(class: 'service_name').text)
    .to match(/EGI AAI Service Provider Proxy/)

  expect(@browser.span(class: 'service_description')).to exist
  expect(@browser.span(class: 'service_description').text)
    .to match(/Service provider proxy for all federated EGI services/)

  # give consent to the proxy one time
  @browser.radio(value: '_shib_idp_doNotRememberConsent').set
  @browser.button(name: '_eventId_proceed', value: 'Accept').click

  @browser.window(title: /consent/i).use
  # say yes to give consent
  @browser.button(text: /yes/i).click

  # if you're a new user to CheckIn, you will get taken to
  # https://aai.egi.eu/registry/co_petitions/start
  # there is a whole flow here which needs to be taken care of independently.

  # Steps
  # 1) Accept to sign up
  # 2) read terms and conditions, then accept
  # 3) sign up
  # 4) get email to click on
  # https://aai.egi.eu/registry/co_invites/reply/<big_hash>
  # 5) confirm : https://aai.egi.eu/registry/co_invites/authconfirm/<big_hash>
end

Then('I am taken back to the main forum') do
  @browser.window(title: 'EGI Foundation').use
  expect(@browser.url).to match(/community\.egi\.eu/)
  # check for modal
  expect(@browser.div(id: 'discourse-modal')).to exist
end

Then('I can see my profile information') do
  # check for login fields
  # expect(@browser.div(class: 'login-form')).to exist
  expect(@browser.text_field(id: 'new-account-email').value)
    .to eq('test@community.egi.eu')
  expect(@browser.text_field(id: 'new-account-username').value)
    .to eq('Dr_Test_Robot')
  expect(@browser.text_field(id: 'new-account-name').value)
    .to eq('Dr Test Robot')
end

After do
  @browser.close
end
