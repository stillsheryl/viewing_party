class MovieApiService
  def self.parse_data(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.top_rated_movies
    page = 1
    top_movies = []

    2.times do
      response = conn.get("/3/movie/top_rated") do |movie|
        movie.params[:page] = page
      end

      movies = parse_data(response)

      top_movies.concat(movies[:results])
      page+=1
    end
    top_movies
  end

  def self.movie_search(query)
    titles = []
    page_number = 0

    2.times do
      page_number += 1
      response = conn.get("/3/search/movie?&page=#{page_number}") do |req|
        req.params[:query] = query
      end

      title_data = parse_data(response)

      titles << title_data[:results]
    end

    titles.flatten
  end

  def self.get_movie_details(movie_id)
    response = conn.get("/3/movie/#{movie_id}") do |movie|
      movie.params[:append_to_response] = 'reviews,credits'
    end

    MovieObject.new(parse_data(response))
  end

  private

  def self.conn
    Faraday.new(url: "https://api.themoviedb.org") do |faraday|
      faraday.params[:api_key] = ENV['MOVIE_DB_API_KEY']
    end
  end
end
