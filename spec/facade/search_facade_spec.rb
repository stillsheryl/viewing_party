require 'rails_helper'

describe SearchFacade do
  it "movie_details can return a movie object with its information" do
    VCR.use_cassette('movie_details') do
      movie_details = SearchFacade.movie_details('372058')

      expect(movie_details.title).to eq('Your Name.')
      expect(movie_details.movie_id).to eq(372058)
      expect(movie_details.vote_average).to eq(8.6)
      expect(movie_details.runtime).to eq(106)
    end
  end

  it "movie_search can return array of hashes with 40 search results" do
    VCR.use_cassette('movie_search') do
      movies = SearchFacade.movie_search("star")

      expect(movies.class).to eq(Array)
      expect(movies[0].class).to eq(Hash)

      expect(movies[0][:title]).to eq("Star Wars")
      expect(movies[39][:title]).to eq("The Sun Is Also a Star")
    end
  end

  it "top_rated_movies returns an array of hashes with top 40 movies " do
    VCR.use_cassette('top_rated_movies') do
      top_movies = SearchFacade.top_rated_movies

      expect(top_movies.class).to eq(Array)
      expect(top_movies.first.class).to eq(Hash)

      expect(top_movies[0][:title]).to eq("Gabriel's Inferno Part III")
      expect(top_movies[0][:vote_average]).to eq(9.3)

      expect(top_movies[8][:title]).to eq("Your Name.")
      expect(top_movies[8][:vote_average]).to eq(8.6)

      expect(top_movies[39][:title]).to eq("Grave of the Fireflies")
      expect(top_movies[39][:vote_average]).to eq(8.4)

      expect(top_movies[40]).to eq(nil)
    end
  end

  it "upcoming_movies returns an array of 40 UpcomingMovie objetcs" do
    VCR.use_cassette('upcoming_movies') do
      upcoming_movies = SearchFacade.upcoming_movies

      expect(upcoming_movies.class).to eq(Array)
      expect(upcoming_movies.first).to be_a(UpcomingMovie)

      expect(upcoming_movies[1].title).to eq("Demon Slayer the Movie: Mugen Train")
      expect(upcoming_movies[1].release_date).to eq("2020-10-16")

      expect(upcoming_movies[39].title).to eq("Akira")
      expect(upcoming_movies[39].release_date).to eq("1988-07-16")\

      expect(upcoming_movies[40]).to eq(nil)
    end
  end
end
