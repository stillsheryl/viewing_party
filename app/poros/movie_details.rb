class MovieDetails
  attr_reader :movie_id,
              :vote_average,
              :title,
              :runtime,
              :genres,
              :overview,
              :cast,
              :reviews,
              :poster

  def initialize(attributes)
    @movie_id = attributes[:id]
    @vote_average = attributes[:vote_average]
    @title = attributes[:title]
    @runtime = attributes[:runtime]
    @genres = attributes[:genres]
    @overview = attributes[:overview]
    @cast = attributes[:credits][:cast]
    @reviews = attributes[:reviews][:results]
    @poster = attributes[:poster_path]
    @similar_movies = attributes[:similar][:results]
  end

  def review_count
    @reviews.count
  end

  def runtime_conversion
    hours = @runtime / 60
    min = @runtime % 60

    if hours.zero?
      "#{min} min"
    else
      "#{hours} hr #{min} min"
    end
  end

  def formatted_reviews
    @reviews.map do |review_data|
      Review.new(review_data)
    end
  end

  def similar_movies
    movies = []
    @similar_movies.each_with_index do |movie, index|
      movies << SimilarMovie.new(movie)
      index += 1
      break if index == 6
    end
    movies
  end

  def formatted_cast
    actor_roles = []

    @cast.each do |cast|
      actor_roles << { cast_id: cast[:cast_id], role: "#{cast[:name]} as #{cast[:character]}" }
      break if actor_roles.count == 10
    end

    actor_roles
  end

  def retrieve_genres
    @genres.map do |genre|
      genre[:name]
    end.join(', ')
  end
end
