Given("I am authenticated") do
	@user = User.create(email: "test@cucumber.com", password: "foobar", password_confirmation: "foobar")
	@user.cars.build(model: "cucumber", battery_capacity: 75).save
	visit new_user_session_path
	fill_in "user_email", with: @user.email
	fill_in "user_password", with: @user.password
	click_button "Log in"
	expect(page).to have_content("Welcome to Smart Path")
end

When("I go to my profile settings page") do
	visit edit_user_registration_path
	expect(page).to have_content("Update your credentials")
end

And("I fill in the username field") do
	fill_in :user_name, with: "cucumber_test"
end

And("I confirm my password") do
	fill_in :user_current_password, with: @user.password
end

And("I press Update") do
	click_button "Update"
end
