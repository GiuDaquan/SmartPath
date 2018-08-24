Feature: Log in
    As an UNREGISTERED USER
    I want to LOGIN WITH E-MAIL
    so that I can USE THE APP

Scenario: Log in
    Given I am not authenticated
    When  I go to log in
    And   I fill in data
    And   I press Log in
    Then  I should see the home page
