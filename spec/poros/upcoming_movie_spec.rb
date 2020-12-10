require 'rails_helper'

describe UpcomingMovie do
  before :each do
    VCR.use_cassette('upcoming_movies') do
      @movies = MovieApiService.upcoming_movies
    end

    @upcoming_movies = UpcomingMovie.new(@movies[0])
  end

  it "exists and has variables" do
    expect(@upcoming_movies).to be_a UpcomingMovie
    expect(@upcoming_movies.movie_id).to eq(@movies[0][:id])
    expect(@upcoming_movies.title).to eq(@movies[0][:title])
    expect(@upcoming_movies.release_date).to eq(@movies[0][:release_date])
  end
end
