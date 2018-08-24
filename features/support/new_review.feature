Feature: Review insertion
	As a USER
	I WANT TO LEAVE A FEEDBACK COMMENT ABOUT THE SERVICE

Scenario: Review insertion
	Given I am authenticated
	When  I go to the review page
	And   I want to post a review
	And   I compile the review
	And   I click post
	Then  I should see my review in the review page
