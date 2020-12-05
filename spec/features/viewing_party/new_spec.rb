require 'rails_helper'

describe 'As an authenticated user' do
  describe 'When I visit the new viewing party page' do
    before(:each) do
      @user1 = User.create!(first_name: 'Zach',
        last_name: 'Stearns',
        email: 'zach@email.com',
        password: 'password')

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      @user2 = User.create!(first_name: 'Angelina',
        last_name: 'Jolie',
        email: 'angie@email.com',
        password: 'tombraider')

      @user3 = User.create!(first_name: 'Tom',
        last_name: 'Myspace',
        email: 'tom@email.com',
        password: 'myspaceforlife')

      @user4 = User.create!(first_name: 'Mark',
        last_name: 'Zuckerberg',
        email: 'zuck@email.com',
        password: 'facebookman')

      @friend1 = Friendship.create!(user_id: @user1.id, friend_id: @user2.id)
      @friend2 = Friendship.create!(user_id: @user1.id, friend_id: @user3.id)
    end

    it "I see a form with the following fields" do
      visit '/viewing-parties/new'

      expect(page).to have_content('')
      expect(page).to have_field(:party_duration)
      expect(page).to have_field(:date)
      expect(page).to have_field(:time)
      expect(page.find("input#friend-#{@friend1.id}")).to_not be_checked
      expect(page.find("input#friend-#{@friend2.id}")).to_not be_checked

      # expect(page).to have_unchecked_field?("input#friend-#{@friend1.id}")
      # expect(page).to have_unchecked_field?("input#friend-#{@friend2.id}")
    end
  end
end
