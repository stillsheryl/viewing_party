require 'rails_helper'

describe MovieObject do
  before :each do
    @attrs = {
      id: 235,
      vote_average: 7.2,
      title: 'Demon Slayer',
      runtime: 106,
      genres: [{name: 'Action'}, {name: 'Adventure'}],
      overview: 'Demon Slayer: Kimetsu no Yaiba the Movie: Mugen Train, also known as Demon Slayer: Mugen Train or Demon Slayer: Infinity Train, is a 2020 Japanese anime period action film, based on the shōnen manga series Demon Slayer: Kimetsu no Yaiba',
      credits: {cast: [{cast_id: 123, name: 'Hanae, Natsuki', character: 'Kamado, Tanjirou'}, {cast_id: 321, name: 'Kitou, Akari', character: 'Kamado, Nezuko'}]},
      reviews: {results: [ { author: 'Gotouge, Koyoharu', id: 256, content: 'content' }]}
    }

    @movie = MovieObject.new(@attrs)
  end

  it "exists" do
    cast_expected = [{:cast_id=>123,:character=>"Kamado, Tanjirou", :name=>"Hanae, Natsuki"}, {:cast_id=>321,:character=>"Kamado, Nezuko", :name=>"Kitou, Akari"}]
    reviews_expected = [{:author=>"Gotouge, Koyoharu", :content=>"content", :id=>256}]

    expect(@movie).to be_a MovieObject
    expect(@movie.movie_id).to eq(@attrs[:id])
    expect(@movie.vote_average).to eq(@attrs[:vote_average])
    expect(@movie.title).to eq(@attrs[:title])
    expect(@movie.runtime).to eq(@attrs[:runtime])
    expect(@movie.genres).to eq(@attrs[:genres])
    expect(@movie.overview).to eq(@attrs[:overview])
    expect(@movie.cast).to eq(cast_expected)
    expect(@movie.reviews).to eq(reviews_expected)
  end

  it "review_count returned the amount of reviews" do
    expect(@movie.review_count).to eq(1)
  end

  it "get_genres returnes all the genres in a string" do
    expect(@movie.get_genres).to eq('Action, Adventure')
    expect(@movie.get_genres.class).to eq(String)
  end

  it "formatted_cast returns the actores and the character they played" do
    expected = [{cast_id: 123, role: 'Hanae, Natsuki as Kamado, Tanjirou'}, {cast_id: 321, role: 'Kitou, Akari as Kamado, Nezuko'}]

    expect(@movie.formatted_cast).to eq(expected)
  end

  it "formatted_reviews returnes the reviews in an array of hashes containing the id, author, and the content" do
    assert_instance_of Array, @movie.formatted_reviews
    assert_instance_of Review, @movie.formatted_reviews[0]
    expect(@movie.formatted_reviews[0].author).to eq('Gotouge, Koyoharu')
    expect(@movie.formatted_reviews[0].content).to eq('content')
    expect(@movie.formatted_reviews[0].review_id).to eq(256)
  end

  it "get_genres returns an ampty string of genres is an empty array" do
    @attrs[:genres] = []
    movie = MovieObject.new(@attrs)

    expect(movie.get_genres).to eq('')
  end

  it "runtime_conversion converts the integer of runtime into hours and minutes" do
    expect(@movie.runtime_conversion).to eq('1 hr 46 min')
  end

  it "runtime_conversion returns only the min if length does not make it to hours" do
    @attrs[:runtime] = 46
    movie = MovieObject.new(@attrs)

    expect(movie.runtime_conversion).to eq('46 min')
  end
end
