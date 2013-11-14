Given(/^I am a guest$/) do
end

When(/^I fill in the registration form with valid data$/) do
	visit("/users/sign_up")
	fill_in "user_email", with: "user1@example.com"
	fill_in "user_password", with: "password55"
	fill_in "user_password_confirmation", with: "password55"
	click_button "Sign up"
end

Then(/^I should be registered as a user$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should be logged in to the application$/) do
  pending # express the regexp above with the code you wish you had
end