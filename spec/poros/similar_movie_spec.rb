require 'rails_helper'

describe UpcomingMovie do
  before :each do
    VCR.use_cassette('similar_movies') do
      @movies = MovieApiService.upcoming_movies
    end

    @similar_movie = MovieSearch.new(@movies[0])
  end

  it "exists and has variables" do
    expect(@similar_movie).to be_a MovieSearch
    expect(@similar_movie.movie_id).to eq(@movies[0][:id])
    expect(@similar_movie.title).to eq(@movies[0][:title])
    expect(@similar_movie.vote_average).to eq(@movies[0][:vote_average])
  end
end
