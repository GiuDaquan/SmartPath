Given("I am not authenticated") do
	visit destroy_user_session_path
end

When("I go to register") do
	visit new_user_registration_path
end

And("I fill in credentials") do
	fill_in "user_email", with: "test@cucumber.com"
    fill_in "user_password", with: "foobar"
	fill_in "user_password_confirmation", with: "foobar"
end

And("I press Register") do
	click_button "Register"
end

Then("I should see the home page" ) do
	expect(page).to have_content("Welcome to Smart Path")
end
