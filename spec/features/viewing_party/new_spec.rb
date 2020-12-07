require 'rails_helper'
require './app/poros/movie_object'
describe 'As an authenticated user' do
  describe 'When I visit the new viewing party page' do
    before(:each) do
      @user1 = User.create!(first_name: 'Zach',
        last_name: 'Stearns',
        email: 'zach@email.com',
        password: 'password')

    #Movie.create!(title: 'Yout name', api_id: 372058, runtime: 106)

      visit  '/'
      fill_in :email,	with: "zach@email.com"
      fill_in :password,	with: "password"
      click_button 'Sign In'

      # allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

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
        @movie = MovieApiService.top_rated_movies[8]
      end

      VCR.use_cassette('movie_details') do
        @movie_details = MovieApiService.get_movie_details(@movie[:id].to_s)
      end

      VCR.use_cassette('movie_details') do
        visit "/movies/#{@movie[:id]}"
        click_button 'Create viewing party for movie'
      end
    end

    it "I see a form with the following fields" do
      # VCR.use_cassette('movie_details') do
        expect(current_path).to eq('/viewing-party/new')
        # Movie title goes here, may need to alter depending on how exactly to add this to test...
        expect(page).to have_content("#{@movie_details.title}")
        expect(page).to have_field(:duration_of_party)
        expect(page).to have_field(:date)
        expect(page).to have_field(:time)
        # This may be weird... we'll see
        within(id="#friends") do
          expect(page).to have_unchecked_field(:"input#friend-#{@friend1.friend_id}")
          # expect(page.find("friend")).to_not be_checked
        end

        within(id="#friends") do
          expect(page).to have_unchecked_field(:"input#friend-#{@friend2.friend_id}")
          # expect(page.find("#input#friend-#{@friend2.friend_id}")).to_not be_checked
        end

        expect(page).to have_button('Create Party')

        # expect(page).to have_unchecked_field?("input#friend-#{@friend2.friend_id}")
      # end
    end

    it "party duration is automatically populated with the movie's runtime in minutes" do
      expect(current_path).to eq('/viewing-party/new')

      # Again, may be altered depending on how movie is called in this test
      expect(find_field(:duration_of_party).value).to eq("#{@movie_details.runtime}")
    end

    it "when I fill in the form with valid information and create the viewing party, I am redirected to the dashboard where I see the new event" do
      expect(current_path).to eq('/viewing-party/new')

      fill_in :date, with: '1/12/2020'
      fill_in :time, with: '2:00 PM'
      find_field("input#friend-#{@friend1.friend_id}").set(true)
      click_button('Create Party')

      expect(current_path).to eq('/dashboard')
      within '#Viewing_Parties' do
        expect(page).to have_content("#{@movie_details.title}")
        # expect(page).to have_content("#{@movie_details.runtime}")
        expect(page).to have_content("December 1, 2020")
        expect(page).to have_content("2:00 PM")
        expect(page).to have_content('Hosting')

        # expect(page).to have_content('Friends Invited')
        # expect(page).to have_content('Angelina Jolie')
        # expect(page).to_not have_content('Tom Myspace')
      end
    end

    it "when I leave the date blank, I get an error that the date can't be blank, I see prepopulated data, and am on the same page" do
      expect(current_path).to eq('/viewing-party/new')

      fill_in :time, with: '2:00 PM'
      find_field("input#friend-#{@friend1.friend_id}").set(true)
      expect(page).to have_checked_field(:"input#friend-#{@friend1.friend_id}")
      save_and_open_page
      click_button('Create Party')

      expect(page).to have_content("Date can't be blank")
      expect(page).to have_content("#{@movie_details.title}")
      # expect(find_field(:date).value)to eq(nil)
      # expect(find_field(:time).value)to eq('2:00 PM')
      # expect(page).to have_field("input#friend-#{@friend1.id}", checked: true)
      expect(page).to have_checked_field(:"input#friend-#{@friend1.friend_id}")
      # expect(page).to have_field("input#friend-#{@friend2.id}", checked: false)
      expect(page).to have_unchecked_field(:"input#friend-#{@friend2.friend_id}")
      expect(page).to have_button('Create Party')
    end

    xit "when I leave the time blank, I get an error that the time can't be blank, I see prepopulated date, and am on the same page" do
      expect(current_path).to eq('/viewing-party/new')

      fill_in :date, with: '1/12/2020'
      find(:css, "input#friend-#{@friend1.id}").set(true)
      click_button('Create Party')

      expect(current_path).to eq('/viewing-party/new')
      expect(page).to have_content("Time can't be blank")
      expect(page).to have_content("#{@movie.title}")
      # expect(find_field(:date).value)to eq(nil)
      # expect(find_field(:time).value)to eq('2:00 PM')
      expect(page).to have_field("input#friend-#{@friend1.id}", checked: true)
      expect(page).to have_field("input#friend-#{@friend2.id}", checked: false)
      expect(page).to have_button('Create Party')
    end

    xit "A viewing party can be created if the user has no friends" do
      user = User.create!(first_name: 'Mark',
        last_name: 'Zuckerberg',
        email: 'zuck@email.com',
        password: 'facebookman')

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      expect(current_path).to eq('/viewing-party/new')

      fill_in :date, with: '1/12/2020'
      fill_in :time, with: '2:00 PM'
      # EXPECT PAGE TO NOT HAVE CHECKBOXES
      click_button('Create Party')

      expect(current_path).to eq('/dashboard')
      within '#Viewing_Parties' do
        expect(page).to have_content("#{@movie.title}")
        expect(page).to have_content("#{@movie.runtime}")
        expect(page).to have_content("December 1, 2020")
        expect(page).to have_content("2:00 PM")
        expect(page).to have_content('Hosting')

        expect(page).to_not have_content('Friends Invited')
      end
    end
  end
end
