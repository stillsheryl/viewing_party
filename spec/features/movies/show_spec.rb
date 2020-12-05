require 'rails_helper'
require './app/poros/movie_object'
describe "As a authenticated user" do
  before :each do
    User.create(email: 'test@gmail.com', password: 'test', first_name: 'Alex', last_name: 'Rivero')

    visit  '/'
    fill_in :email,	with: "test@gmail.com"
    fill_in :password,	with: "test"
    click_button 'Sign In'

    VCR.use_cassette('top_rated_movies') do
      @movie = MovieApiService.top_rated_movies[8]
      @movie_no_genres_reviews = MovieApiService.top_rated_movies[0]
    end

    VCR.use_cassette('movie_details') do
      @movie_details = MovieApiService.get_movie_details(@movie[:id].to_s)
    end

    VCR.use_cassette('movie_no_genres_reviews') do
      @movie_no_genres_reviews_object = MovieApiService.get_movie_details(@movie_no_genres_reviews[:id].to_s)
    end
  end

  it "I can click and visit the movie datails page" do
    VCR.use_cassette('top_rated_movies') do
      visit '/movies/top_rated'

      VCR.use_cassette('movie_details') do
        click_link @movie[:title]
        expect(current_path).to eq("/movies/#{@movie[:id]}")
      end
    end
  end

  it "I can see movie name vote average, runtime, genre's" do
    VCR.use_cassette('movie_details') do
      visit "/movies/#{@movie_details.movie_id}"

      expect(page).to have_content('Your Name.')

      within('#details') do
        expect(page).to have_content("Vote Average: #{@movie_details.vote_average}")
        expect(page).to have_content("Runtime: #{@movie_details.runtime_convertion}")
        expect(page).to have_content("Genre(s): #{@movie_details.get_genres}")
      end
    end
  end

  it "I can see the movie summary" do
    VCR.use_cassette('movie_details') do
      visit "/movies/#{@movie_details.movie_id}"

      within('#summary') do
        expect(page).to have_content('Summary')
        expect(page).to have_content(@movie_details.overview)
      end
    end
  end

  it "I can see the movieies cast and their character" do
    VCR.use_cassette('movie_details') do
      visit "/movies/#{@movie_details.movie_id}"

      expect(page).to have_content('Cast')

      within('#cast') do
        #testing the first cast member
        within("#cast-#{@movie_details.cast[0][:cast_id]}") do
          expect(page).to have_content("#{@movie_details.cast[0][:name]} as #{@movie_details.cast[0][:character]}")
        end
        #testing the last cast member
        within("#cast-#{@movie_details.cast[9][:cast_id]}") do
          expect(page).to have_content("#{@movie_details.cast[9][:name]} as #{@movie_details.cast[9][:character]}")
        end
      end
    end
  end

  it "I can see the movie summary" do
    VCR.use_cassette('movie_details') do
      visit "/movies/#{@movie_details.movie_id}"

      expect(page).to have_content("#{@movie_details.review_count} Reviews")

      within('#reviews') do
        #testing first review
        within("#review-#{@movie_details.reviews[0][:id]}") do
          expect(page).to have_content("Author: #{@movie_details.reviews[0][:author]}")
          expect(page).to have_content(@movie_details.reviews[0][:content].sub!('\r', '\r\n'))
        end
        #testing last review
        within("#review-#{@movie_details.reviews[2][:id]}") do
          expect(page).to have_content("Author: #{@movie_details.reviews[2][:author]}")
          expect(page).to have_content(@movie_details.reviews[2][:content].sub!('\r', '\r\n'))
        end
      end
    end
  end

  it "I cannot see a reviews section css if there are no reviews" do
    VCR.use_cassette('movie_no_genres_reviews') do
      visit "/movies/#{@movie_no_genres_reviews_object.movie_id}"

      expect(page).to_not have_css('#reviews')
    end
  end

  it "I cannot see a cast section css if there are no cast information" do
    VCR.use_cassette('movie_no_genres_reviews') do
      visit "/movies/#{@movie_no_genres_reviews_object.movie_id}"

      expect(page).to_not have_css('#cast')
    end
  end
end
