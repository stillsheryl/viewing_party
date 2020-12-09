require 'rails_helper'

describe SearchFacade do
  it "movie_details can return a movie object with its information" do
    VCR.use_cassette('movie_details') do
      @movie_details = SearchFacade.movie_details('372058')

      expect(@movie_details.title).to eq('Your Name.')
      expect(@movie_details.movie_id).to eq(372058)
      expect(@movie_details.vote_average).to eq(8.6)
      expect(@movie_details.runtime).to eq(106)
    end
  end

  it "movie_search can return array of hashes with 40 search results" do
    VCR.use_cassette('movie_search') do
      @movies = SearchFacade.movie_search("star")
      expect(@movies.class).to eq(Array)
      expect(@movies[0].class).to eq(Hash)

      expect(@movies[0][:title]).to eq("Star Wars")
      expect(@movies[39][:title]).to eq("The Sun Is Also a Star")
    end
  end

  it "top_rated_movies returns an array of hashes with top 40 movies " do
    VCR.use_cassette('top_rated_movies') do
      @top_movies = SearchFacade.top_rated_movies
      expect(@top_movies.class).to eq(Array)
      expect(@top_movies[0].class).to eq(Hash)

      expect(@top_movies[0][:title]).to eq("Gabriel's Inferno Part III")
      expect(@top_movies[0][:vote_average]).to eq(9.3)

      expect(@top_movies[8][:title]).to eq("Your Name.")
      expect(@top_movies[8][:vote_average]).to eq(8.6)

      expect(@top_movies[39][:title]).to eq("Grave of the Fireflies")
      expect(@top_movies[39][:vote_average]).to eq(8.4)
    end
  end
end
