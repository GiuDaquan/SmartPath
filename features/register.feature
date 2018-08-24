Feature: Registation
    As an UNREGISTERED USER
    I want to LOGIN WITH E-MAIL
    so that I can BECOME A USER

Scenario: Registration
    Given I am not authenticated
    When  I go to register
    And   I fill in credentials
    And   I press Register
    Then  I should see the home page
