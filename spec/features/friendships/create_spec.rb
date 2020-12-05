require 'rails_helper'

describe "As a registered user" do
  describe "When I am on my dashboard" do
    before(:each) do
      @user1 = User.create!(first_name: 'Zach',
        last_name: 'Stearns',
        email: 'zach@email.com',
        password: 'password')

      @user2 = User.create!(first_name: 'Angelina',
        last_name: 'Jolie',
        email: 'angie@email.com',
        password: 'tombraider')

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
    end

    it "I see a search bar to add friends" do
      visit '/dashboard'

      expect(page).to have_field(:email)
    end
  end
end
