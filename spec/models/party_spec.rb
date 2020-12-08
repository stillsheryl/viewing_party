require 'rails_helper'

describe Party, type: :model do
  describe "relationships" do
    it { should belong_to :movie }
    it { should belong_to :user }
    it { should have_many :guests }
  end

  describe "validations" do
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :movie_id }
    it { should validate_presence_of :date }
    it { should validate_presence_of :time }
    it { should validate_presence_of :duration }
  end

  describe 'methods' do
    before :each do
      User.create(email: 'test@gmail.com', password: 'test', first_name: 'Alex', last_name: 'Rivero')
      current_user = User.last
      movie = Movie.create!(title: 'Avengers', api_id: 550)
      @party = Party.create!(user_id: current_user.id, movie_id: movie.id, date: '1/12/2020', time: '2 PM', duration: 220)
    end

    it ".formatted_date" do
      expect(@party.formatted_date).to eq('December  1, 2020')
    end

    it ".formatted_time" do
      expect(@party.formatted_time).to eq(' 2:00 PM')
    end
  end
end
