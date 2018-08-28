require "rails_helper"

RSpec.describe StaticPagesController, :type => :controller do


  it "should render the home page" do
		get :home
		expect(response).to render_template(:home)
  end

	it "should render the about page" do
		get :about
		expect(response).to render_template(:about)
	end

	it "should render the search page" do
		@user = User.create(:email => "prova@rspec.com", :password => "foobar", :password_confirmation => 'foobar')
		@car = Car.create(:model => 'test', :battery_capacity => 50, :user_id => @user.id)
		sign_in @user
		get :search
		expect(response).to render_template(:search)
	end


end
