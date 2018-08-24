When("I go to log in") do
	visit new_user_session_path
end

And("I fill in data") do
	@user = User.create(email: "test@cucumber.com", password: "foobar", password_confirmation: "foobar")
	fill_in "user_email", with: @user.email
	fill_in "user_password", with: @user.password
end

And("I press Log in") do
	click_button "Log in"
end
