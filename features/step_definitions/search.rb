When("I go to the search page") do
	visit search_path
	expect(page).to have_content("Search for a smart path")
end

And("I fill in the informations") do
	select @user.cars.first.model, from: "user_input_battery_capacity"
	fill_in :user_input_origin,           with: "Trento"
	fill_in :user_input_destination,      with: "Roma"
	ChargingPoint.create(name: "test", longitude: 12.48278, latitude: 41.89306)
	ChargingPoint.create(name: "test", longitude: 14.25, latitude: 40.83333)
end

And("I press Search") do
	click_button "Search"
end

Then ("I should see the result") do
	expect(page).to have_content("Result")
end
