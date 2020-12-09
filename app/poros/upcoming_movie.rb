class UpcomingMovie
  attr_reader :movie_id,
              :title,
              :release_date

  def initialize(movie)
    @movie_id = movie[:id]
    @title = movie[:title]
    @release_date = movie[:release_date]
  end
end
