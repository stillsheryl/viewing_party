require 'rails_helper'

describe 'As a user' do
  before :each do
    User.create(email: 'test@gmail.com', password: 'test', first_name: 'Alex', last_name: 'Rivero')

    visit root_path
    fill_in :email,	with: "test@gmail.com"
    fill_in :password,	with: "test"
    click_button 'Sign In'
  end

  it "From the discover page I can click on Upcoming movies and see upcoming movies page" do
    VCR.use_cassette('upcoming_movies') do
      visit discover_path

      click_button 'Upcoming Movies'

      expect(current_path).to eq(movies_upcoming_path)
    end
  end

  it "There are 40 upcoming movies on the page" do
    VCR.use_cassette('upcoming_movies') do
      visit movies_upcoming_path

      expect(page).to have_css('.movie-column', count: 40)
      expect(page).to have_css('.vote-column', count: 40)
    end
  end

  it "Page has the buttons for top, upcoming and movie search" do
    VCR.use_cassette('top_rated_movies') do
      visit movies_top_rated_path

      expect(page).to have_button('Find Top Rated Movies')
      expect(page).to have_button('Find Movies')
      expect(page).to have_button('Upcoming Movies')
    end
  end
end
