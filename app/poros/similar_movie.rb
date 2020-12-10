class SimilarMovie
  attr_reader :movie_id,
              :title,
              :vote_average

  def initialize(movie)
    @movie_id = movie[:id]
    @title = movie[:title]
    @vote_average = movie[:vote_average]
  end
end
