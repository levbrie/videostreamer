Feature: User Registration

To register as a user, a site visitor must first go to the registration form
and fill out their email, password, and an identical password confirmation.
After successfully registering the user can then log in.

	Scenario: User registers successfully
		Given I am a guest
		When I fill in the registration form with valid data
		Then I should be registered as a user
		And I should be logged in to the application