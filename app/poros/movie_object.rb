# require_relative 'review.rb'
class MovieObject
  attr_reader :movie_id,
              :vote_average,
              :title,
              :runtime,
              :genres,
              :overview,
              :cast,
              :reviews

  def initialize(attributes)
    @movie_id = attributes[:id]
    @vote_average = attributes[:vote_average]
    @title = attributes[:title]
    @runtime = attributes[:runtime]
    @genres = attributes[:genres]
    @overview = attributes[:overview]
    @cast = attributes[:credits][:cast]
    @reviews = attributes[:reviews][:results]
  end

  def review_count
    @reviews.count
  end

  def runtime_conversion
    hours = @runtime / 60
    min = @runtime % 60

    if hours == 0
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

  def formatted_cast
    actor_roles = []

    @cast.each do |cast|
      actor_roles << {cast_id: cast[:cast_id], role: "#{cast[:name]} as #{cast[:character]}"}
      if actor_roles.count == 10
        break
      end
    end

    actor_roles
  end

  def get_genres
    @genres.map do |genre|
      genre[:name]
    end.join(', ')
  end
end
