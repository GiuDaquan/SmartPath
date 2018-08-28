require "rails_helper"

RSpec.describe ReviewsController, :type => :controller do

  it "should render the reviews page" do
		get :index
		expect(response).to render_template(:index)
  end

	describe "Review insertion request with no login" do
		it "should not render the review insertion page" do
			get :new
			expect(response).not_to render_template(:new)
		end
	end

	describe "Rightful Review insertion request" do
		it "should render the review insertion page" do
			@user = User.create(:email => "prova@rspec.com", :password => "foobar", :password_confirmation => 'foobar')
			sign_in @user
			get :new
			expect(response).to render_template(:new)
		end
	end

	describe "Multiple Review insertion request" do
		it "should not render the review insertion page" do
			@user = User.create(:email => "prova@rspec.com", :password => "foobar", :password_confirmation => 'foobar')
			@review = Review.create(content: "test", rating: 1, user_id: @user.id)
			sign_in @user
			get :new
			expect(response).not_to render_template(:new)
		end
	end

	describe "Review insertion with no login" do
		it "should not render the reviews page" do
			@user = User.create(:email => "prova@rspec.com", :password => "foobar", :password_confirmation => 'foobar')
			@review = Review.create(content: "test", rating: 1, user_id: @user.id)
			post :create
			expect(response).not_to render_template(:reviews)
		end
	end

	describe "Rightful review insertion" do
		it "should render the reviews page" do
			@user = User.create(:email => "prova@rspec.com", :password => "foobar", :password_confirmation => 'foobar')
			sign_in @user
			@review = Review.create(content: "test", rating: 1, user_id: @user.id)
			post :create
			expect(response).not_to render_template(:reviews)
		end
	end

	describe "Review update request with no login" do
		it "should not render the review update page" do
			@user = User.create(:email => "prova@rspec.com", :password => "foobar", :password_confirmation => 'foobar')
			@review = Review.create(content: "test", rating: 1, user_id: @user.id)
			get :edit, params: { id: @review.id }
			expect(response).not_to render_template(:edit)
		end
	end

  describe "Review update request for a different user" do
		it "should not render the review update page" do
			@user = User.create(:email => "prova@rspec.com", :password => "foobar", :password_confirmation => 'foobar')
      @user_2 = User.create(:email => "prova@rspec.com", :password => "foobar", :password_confirmation => 'foobar')
      sign_in @user_2
			@review = Review.create(content: "test", rating: 1, user_id: @user.id)
			get :edit, params: { id: @review.id }
			expect(response).not_to render_template(:edit)
		end
	end

	describe "Rightful Review update request" do
		it "should render the review update page" do
			@user = User.create(:email => "prova@rspec.com", :password => "foobar", :password_confirmation => 'foobar')
			sign_in @user
			@review = Review.create(content: "test", rating: 1, user_id: @user.id)
			get :edit, params: { id: @review.id }
			expect(response).to render_template(:edit)
		end
	end

end
