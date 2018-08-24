Feature: Username update
	As a USER
	I want to HAVE SETTINGS
	so that I can CHANGE MY USERNAME

Scenario: Username update
    Given I am authenticated
    When  I go to my profile settings page
    And   I fill in the username field
	And   I confirm my password
    And   I press Update
    Then  I should see the home page
