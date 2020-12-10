require 'rails_helper'

describe 'As a user' do
  before :each do
    User.create(email: 'test@gmail.com', password: 'test', first_name: 'Alex', last_name: 'Rivero')

    visit root_path
    fill_in :email,	with: "test@gmail.com"
    fill_in :password,	with: "test"
    click_button 'Sign In'

    @current_user = User.last

    VCR.use_cassette('retreive_avengers') do
      @avengers = SearchFacade.movie_details('24428')
    end

    @movie = Movie.create!(title: "#{@avengers.title}", api_id: "#{@avengers.movie_id}")
    @party = Party.create!(user_id: @current_user.id, movie_id: @movie.id, date: '1/12/2020', time: '2:00 PM', duration: 220)
  end

  it "I am in the dashboard link" do
    expect(current_path).to eq(dashboard_path)
  end

  it "Has clickable button to Discover movies" do
    expect(page).to have_button('Discover Movies')

    click_button 'Discover Movies'

    expect(current_path).to eq(discover_path)
  end

  it "Page has a textbox and a button to add friend" do
    within id="#Friends" do
      expect(page).to have_css('input[type="text"]')
      expect(page).to have_button('Add Friend')
    end
  end

  it "User currently has no friends" do
    within id="#Friends" do
      expect(page).to have_content('You currently have no friends')
    end
  end

  it "Section show current parties and their info for user if any" do
    Guest.create(party_id: @party.id, user_id: @current_user.id, attending: true)

    visit dashboard_path

    within id="#party-#{@party.id}" do
      expect(page).to have_content('Avengers')
      expect(page).to have_content('December 1, 2020')
      expect(page).to have_content('2:00 PM')
      expect(page).to have_content('Hosting')
    end
  end

  it "Party has invited when the user is a guest and not the host" do
    click_link 'Logout'
    User.create(email: 'test@test.com', password: 'testing', first_name: 'James', last_name: 'Morgan')

    visit root_path
    fill_in :email,	with: "test@test.com"
    fill_in :password,	with: "testing"
    click_button 'Sign In'

    current_user = User.last
    Guest.create(party_id: @party.id, user_id: current_user.id, attending: true)

    visit dashboard_path

    within id="#party-#{@party.id}" do
      expect(page).to have_link("#{@movie.title}")
      expect(page).to have_content('December 1, 2020')
      expect(page).to have_content('2:00 PM')
      expect(page).to have_content('Invited')
    end
  end

  it "Clicking on the movie name in the viewing party display takes me to the movie show page" do
    Guest.create(party_id: @party.id, user_id: @current_user.id, attending: true)

    VCR.use_cassette('retreive_avengers') do
      visit dashboard_path

      within "#party-#{@party.id}" do
        click_link("#{@movie.title}")
      end

      expect(current_path).to eq(movie_show_path("#{@avengers.movie_id}"))
    end
  end
end
