class MoviesController < ApplicationController
  before_action :require_user

  def index
    if params[:movie_title] != ''
      @titles = SearchFacade.movie_search(params[:movie_title])
    else
      flash[:error] = 'Search field cannot be blank'
      redirect_to discover_path
    end
  end

  def show
    @movie = SearchFacade.movie_details(params[:movie_id])
  end

  def top_rated
    @top_movies = SearchFacade.top_rated_movies
  end

  def upcoming
    @upcoming_movies = SearchFacade.upcoming_movies
  end
end
