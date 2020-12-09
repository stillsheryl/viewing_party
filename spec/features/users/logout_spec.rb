require 'rails_helper'

describe "As a registered user" do
  describe "When I click the logout button" do
    it "I am logged out, see a successful flash, and redirected to root page" do
      user = User.create!(first_name: 'Zach',
        last_name: 'Stearns',
        email: 'zach@email.com', 
        password: 'password')

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      click_link "Logout"
      expect(current_path).to eq(root_path)
      expect(page).to have_content('Logout Successful!')
    end
  end
end
