class MoviesController < ApplicationController
  before_action :require_user

  def index
    if params[:movie_title] != ''
      @titles = MovieApiService.movie_search(params[:movie_title])
    else
      flash[:error] = 'Search field cannot be blank'
      redirect_to '/discover'
    end
  end

  def show
    @movie = MovieApiService.get_movie_details(params[:movie_id])
  end

  def top_rated
    @top_movies = MovieApiService.top_rated_movies
  end
end
