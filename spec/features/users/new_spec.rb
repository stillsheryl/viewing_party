require 'rails_helper'

describe 'User Registration' do
  describe 'As a visitor' do
    it 'shows a form to register as a new user, and when I enter valid information I am redirected to the dashboard' do
      visit '/registration'

      fill_in 'First name', with: 'Sam'
      fill_in 'Last name', with: 'Smith'
      fill_in 'Email', with: 'sam@email.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'

      click_button 'Register'

      expect(current_path).to eq('/dashboard')
      expect(page).to have_content('Your account has successfully been created, Sam.')

      user = User.last

      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end

    it 'displays an error if any required field is left blank' do
      visit '/registration'

      fill_in 'First name', with: 'Sam'

      click_button 'Register'

      expect(page).to have_content("Last name can't be blank")
      expect(page).to have_content("Email can't be blank")
      expect(page).to have_content("Password can't be blank")
    end

    it 'displays an error if the email provided already exists in the database' do
      User.create!(first_name: "Sam", last_name: "Smith", email: "sam@email.com", password: "bestpassword")

      visit '/registration'

      fill_in 'First name', with: 'Sammie'
      fill_in 'Last name', with: 'Smith'
      fill_in 'Email', with: 'sam@email.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'

      click_button 'Register'

      expect(page).to have_content("Email has already been taken")
    end

    it 'displays an error if the two passwords do not match' do
      visit '/registration'

      fill_in 'First name', with: 'Sammie'
      fill_in 'Last name', with: 'Smith'
      fill_in 'Email', with: 'sam@email.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'p@ssword'

      click_button 'Register'

      expect(page).to have_content("Password confirmation doesn't match Password")
    end

    it "prefills information that user has already provided, besides the passwords, in the case that a form error occurs" do
      visit '/registration'

      fill_in 'First name', with: 'Sammie'
      fill_in 'Last name', with: 'Smith'
      fill_in 'Email', with: 'sam@email.com'
      fill_in 'Password', with: 'password'

      click_button 'Register'

      expect(page).to have_content("Password confirmation doesn't match Password")

      expect(find_field('First name').value).to eq 'Sammie'
      expect(find_field('Last name').value).to eq 'Smith'
      expect(find_field('Email').value).to eq 'sam@email.com'
      expect(find_field('Password').value).to eq nil
      expect(find_field('Password confirmation').value).to eq nil
    end
  end
end
