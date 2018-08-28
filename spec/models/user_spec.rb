require "rails_helper"

RSpec.describe User, :type => :model do

  describe "User creation without password" do
    it "Should not be valid" do
      user = User.new(:email => "prova@rspec.com")
      expect(user).not_to be_valid
    end
  end

	describe "User creation without email" do
    it "Should not be valid" do
      user = User.new(:password => "foobar", :password_confirmation => 'foobar')
      expect(user).not_to be_valid
    end
  end

	describe "User creation with invalid email" do
		it "Should not be valid" do
			user = User.new(:email => "prova.rspec.com", :password => "foobar", :password_confirmation => 'foobar')
			expect(user).not_to be_valid
		end
	end

	describe "User creation with short password" do
		it "Should not be valid" do
			user = User.new(:email => "prova.rspec.com", :password => "foo", :password_confirmation => 'foo')
			expect(user).not_to be_valid
		end
	end

	describe "Rightful User creation" do
		it "Should be valid" do
			user = User.new(:email => "prova@rspec.com", :password => "foobar", :password_confirmation => 'foobar')
			expect(user).to be_valid
		end
	end

end
