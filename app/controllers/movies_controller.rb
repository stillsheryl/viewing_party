class MoviesController < ApplicationController
  def index
    @pet_results
    if params[:movie_title] != nil && params[:movie_title] != ""
      @titles = MovieApiService.movie_search(params[:movie_title])
      
    end
  end

  def top_rated
    @top_movies = MovieApiService.top_rated_movies
  end
end
