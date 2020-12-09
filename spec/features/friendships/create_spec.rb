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

    it "filling in the search bar with an existing email address and clicking Add Friend, that friend gets added to my friends list" do
      visit '/dashboard'

      within '#Friends' do
        expect(page).to have_content('You currently have no friends')
      end

      fill_in :email, with: "#{@user2.email}"
      click_button('Add Friend')

      @user1.reload
      expect(current_path).to eq('/dashboard')

      within '#Friends' do
        expect(page).to have_content('Angelina Jolie')
      end

      expect(page).to have_content('We let Angelina know that you added them as a friend.')
    end

    it "filling in the search bar with an email that does not exist and clicking Add Friend, my friends list does not change and I get an error message saying that my friend cannot be found" do
      visit '/dashboard'

      within '#Friends' do
        expect(page).to have_content('You currently have no friends')
      end

      fill_in :email, with: 'billyjoehenrybob@email.com'
      click_button('Add Friend')

      expect(current_path).to eq('/dashboard')
      expect(page).to have_content("I'm sorry your friend cannot not found.")

      within '#Friends' do
        expect(page). to have_content('You currently have no friends')
      end
    end

    it "Clicking the Add Friend button without entering anything returns an error" do
      visit '/dashboard'

      click_button('Add Friend')

      expect(page).to have_content("I'm sorry your friend cannot not found.")
    end

    it "Entering an email of a friend of whom you are already friends with notifies you that you're friends and does not duplicate that person in your friends list" do
      visit '/dashboard'

      within '#Friends' do
        expect(page).to have_content('You currently have no friends')
      end

      fill_in :email, with: 'angie@email.com'
      click_button('Add Friend')

      expect(current_path).to eq('/dashboard')
      within '#Friends' do
        expect(page).to have_content('Angelina Jolie')
      end

      fill_in :email, with: 'angie@email.com'
      click_button('Add Friend')

      expect(current_path).to eq('/dashboard')
      expect(page).to have_content('You are already friends.')

      within '#Friends' do
        expect(page).to have_content('Angelina Jolie', count: 1)
      end
    end

    it 'sends an email when a friendship is created' do
      Friendship.create!(user_id: @user1.id, friend_id: @user2.id)

      info = {
        user: @user1,
        friend: @user2.first_name,
      }
      recipient = @user2.email

      expect { FriendNotifierMailer.inform(info, recipient) }
        .to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
