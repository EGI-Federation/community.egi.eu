Feature: Log in with CheckIn A person with an identity can log in with CheckIn
  Scenario: The login button is present
    Given I visit the main page
    When I look for the login button
    Then it is present
