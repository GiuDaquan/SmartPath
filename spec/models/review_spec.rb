require "rails_helper"

RSpec.describe Review, :type => :model do

  describe "Review creation without rating" do
    it "Should not be valid" do
      review = Review.new
      expect(review).not_to be_valid
    end
  end

	describe "Review creation with over extended content" do
    it "Should not be valid" do
			s = (0...500).map { |i| i.to_s }.join
      review = Review.new(rating: 4, content: s)
      expect(review).not_to be_valid
    end
  end

	describe "Review creation with no owner" do
    it "Should not be valid" do
      review = Review.new(rating: 4, content: "Test")
      expect(review).not_to be_valid
    end
  end

	describe "Multiple review creation by a single user" do
    it "Should not be valid" do
      user = User.create(:email => "prova@rspec.com", :password => "foobar", :password_confirmation => 'foobar')
			rigthful_review = Review.create(rating: 3, content: "Example", user_id: user.id)
			multiple_review = Review.create(rating: 4, content: "Test", user_id: user.id)
      expect(multiple_review).not_to be_valid
    end
  end

	describe "Rightful review creation" do
    it "Should be valid" do
      user = User.create(:email => "prova@rspec.com", :password => "foobar", :password_confirmation => 'foobar')
			review = user.build_review(rating: 4, content: "Test")
      expect(review).to be_valid
    end
  end

end
