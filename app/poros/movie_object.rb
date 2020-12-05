class MovieObject
  attr_reader :title, :movie_id, :vote_average, :runtime, :genres, :overview, :cast, :reviews

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

  def formatted_reviews
    reviews = []

    @reviews.each do |review|
      reviews << {review_id: review[:id], author: review[:author], content: review[:content]}
    end

    reviews
  end

  def formatted_cast
    actor_roles = []

    @cast.each do |cast|
      actor_roles << {cast_id: cast[:cast_id], role: "#{cast[:name]} as #{cast[:character]}"}
    end
    
    actor_roles
  end

  def get_genres
    genres = ''
    if @genres
      @genres.each do |genre|
        if genres == ''
          genres = genre[:name]
        else
          genres += ", #{genre[:name]}"
        end
      end
    end
    genres
  end
end
