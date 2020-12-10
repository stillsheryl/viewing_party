require 'rails_helper'
require './app/poros/movie_details'
describe 'As an authenticated user' do
  describe 'When I visit the new viewing party page' do
    before(:each) do
      @user1 = User.create!(first_name: 'Zach',
        last_name: 'Stearns',
        email: 'zach@email.com',
        password: 'password')

      visit root_path
      fill_in :email,	with: "zach@email.com"
      fill_in :password,	with: "password"
      click_button 'Sign In'

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

      VCR.use_cassette('top_rated_movies') do
        @movie = SearchFacade.top_rated_movies[8]
      end

      VCR.use_cassette('movie_details') do
        @movie_details = SearchFacade.movie_details(@movie[:id].to_s)
      end

      VCR.use_cassette('movie_details') do
        visit movie_show_path(@movie[:id])
        click_button 'Create viewing party for movie'
      end
    end

    it "I see a form with the following fields" do
      expect(current_path).to eq(viewing_party_new_path)
      expect(page).to have_content("#{@movie_details.title}")
      expect(page).to have_field(:duration_of_party)
      expect(page).to have_field(:date)
      expect(page).to have_field(:time)

      within(id="#friends") do
        expect(page).to have_unchecked_field(:"friend-#{@friend1.friend_id}")
      end

      within(id="#friends") do
        expect(page).to have_unchecked_field(:"friend-#{@friend2.friend_id}")
      end

      expect(page).to have_button('Create Party')
    end

    it "party duration is automatically populated with the movie's runtime in minutes" do
      expect(current_path).to eq(viewing_party_new_path)

      expect(find_field(:duration_of_party).value).to eq("#{@movie_details.runtime}")
    end

    it "when I fill in the form with valid information and create the viewing party, I am redirected to the dashboard where I see the new event" do
      expect(current_path).to eq(viewing_party_new_path)

      fill_in :date, with: '1/12/2020'
      fill_in :time, with: '2:00 PM'
      find_field("friend-#{@friend1.friend_id}").set(true)
      click_button('Create Party')

      expect(current_path).to eq(dashboard_path)
      within '#Viewing_Parties' do
        expect(page).to have_content("#{@movie_details.title}")

        expect(page).to have_content("December 1, 2020")
        expect(page).to have_content("2:00 PM")
        expect(page).to have_content('Hosting')
      end
    end

    it "when I leave the date blank, I get an error that the date can't be blank" do
      expect(current_path).to eq(viewing_party_new_path)

      fill_in :time, with: '2:00 PM'
      find_field("friend-#{@friend1.friend_id}").set(true)
      expect(page).to have_checked_field(:"friend-#{@friend1.friend_id}")
      click_button('Create Party')

      expect(page).to have_content("Date can't be blank")
      expect(page).to have_content("#{@movie_details.title}")
      expect(page).to have_button('Create Party')
    end

    it "when I leave the time blank, I get an error that the time can't be blank" do
      expect(current_path).to eq(viewing_party_new_path)

      fill_in :date, with: '1/12/2020'
      find_field("friend-#{@friend1.friend_id}").set(true)
      click_button('Create Party')

      expect(page).to have_content("Time can't be blank")
      expect(page).to have_content("#{@movie_details.title}")
      expect(page).to have_button('Create Party')
    end

    it "A viewing party can be created if the user has no friends" do
      user = User.create!(first_name: 'Mark',
        last_name: 'Zuckerberg',
        email: 'rando@email.com',
        password: 'facebookman')

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      expect(current_path).to eq(viewing_party_new_path)

      fill_in :date, with: '1/12/2020'
      fill_in :time, with: '2:00 PM'
      click_button('Create Party')

      expect(current_path).to eq(dashboard_path)
      within '#Viewing_Parties' do
        expect(page).to have_content("#{@movie_details.title}")
        expect(page).to have_content("December 1, 2020")
        expect(page).to have_content("2:00 PM")
        expect(page).to have_content('Hosting')

        expect(page).to_not have_content('Friends Invited')
      end
    end
  end
end
