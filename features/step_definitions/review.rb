When ("I go to the review page") do
	visit reviews_path
end

And ("I want to post a review") do
	click_on "Post a review"
end

And ("I compile the review") do
	visit new_review_path
	fill_in :review_content, with: "Very nice"
	fill_in :review_rating, with: 4
end

And ("I click post") do
	click_button "Post"
end

Then ("I should see my review in the review page") do
	expect(page).to have_content("Reviews")
end
