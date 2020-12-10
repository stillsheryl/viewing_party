class SearchFacade
  def self.movie_search(title)
    MovieApiService.movie_search(title)
  end

  def self.movie_details(movie_id)
    response = MovieApiService.get_movie_details(movie_id)
    MovieObject.new(response)
  end

  def self.top_rated_movies
    MovieApiService.top_rated_movies
  end

  def self.upcoming_movies
    movies = MovieApiService.upcoming_movies
    movies.map do |movie|
      UpcomingMovie.new(movie)
    end
  end
end
