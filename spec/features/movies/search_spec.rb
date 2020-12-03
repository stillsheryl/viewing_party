require 'rails_helper'

describe "As a registered user" do
  describe "On the discover page" do
    before(:each) do
      @user = User.create!(first_name: 'Zach',
        last_name: 'Stearns',
        email: 'zach@email.com',
        password: 'password')

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it "When I make an entry in the search bar, I see my case-insensitive movie title results
        and the voting average listed on the movies index page" do
      
      VCR.use_cassette('movie_search') do
        visit '/discover'
  
        fill_in :movie_title,	with: "star"
        click_button 'Find Movies'
        expect(current_path).to eq('/movies')
  
        within all('.movie-results')[0] do
          expect(page).to have_content(/star/i)
        end
  
        within all('.movie-results')[22] do
          expect(page).to have_content(/star/i)
        end
  
        within all('.movie-results')[39] do
          expect(page).to have_content(/star/i)
        end
      end
    end

    it "I see no more than 40 results" do
      VCR.use_cassette('movie_search') do
        visit '/discover'
  
        fill_in :movie_title,	with: "star"
        click_button 'Find Movies'
        expect(current_path).to eq('/movies')
  
        expect(page).to have_css('.movie-column', count: 40)
        expect(page).to have_css('.vote-column', count: 40)        
      end
    end
  end
end
