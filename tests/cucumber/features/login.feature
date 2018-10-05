Feature: Log in with CheckIn A person with an identity can log in with CheckIn
  Background: I start on the home page
    Given I am a test user 
    And I am on the main page
  
  Scenario: The login button is present
    Given I visit the main page
    When I look for the login button
    Then it is present

  Scenario: A test user visits the forum to log in
    Given I click on the login button
    Then I am taken to EGI AAI
    Then I choose SSO
    And I add my credentials
    Then I am asked to release my attributes
    Then I am taken back to the main forum
    And I can see my profile information