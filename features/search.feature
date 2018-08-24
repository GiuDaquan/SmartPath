Feature: Search
	As a USER
	I want to USE PATH SEARCH
	so that I can FIND THE BEST PATH

Scenario: Search
	Given I am authenticated
 	When  I go to the search page
	And   I fill in the informations
	And   I press Search
	Then  I should see the result
