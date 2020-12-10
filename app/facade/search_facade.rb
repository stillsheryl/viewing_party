class SearchFacade
  def self.movie_search(title)
    movies = MovieApiService.movie_search(title)
    movies.map do |movie|
      SimilarMovie.new(movie)
    end
  end

  def self.movie_details(movie_id)
    response = MovieApiService.get_movie_details(movie_id)
    MovieDetails.new(response)
  end

  def self.top_rated_movies
    movies = MovieApiService.top_rated_movies

    movies.map do |movie|
      SimilarMovie.new(movie)
    end
  end

  def self.upcoming_movies
    movies = MovieApiService.upcoming_movies
    movies.map do |movie|
      UpcomingMovie.new(movie)
    end
  end
end
