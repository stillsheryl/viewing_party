class MoviesController < ApplicationController
  def index
    @titles = MovieApiService.movie_search(params[:movie_title])
  end

  def show
    @movie = MovieApiService.get_movie_details(params[:movie_id])
  end

  def top_rated
    @top_movies = MovieApiService.top_rated_movies
  end
end
