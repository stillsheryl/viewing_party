class ViewingPartiesController < ApplicationController
  before_action :require_user
  
  def new
    @movie = Movie.find_by(api_id: params[:movie_id])
    @movie ||= Movie.create(title: params[:title], runtime: params[:runtime], api_id: params[:movie_id]) if @movie.nil?
  end

  def create
    @movie = Movie.find_by(api_id: params[:movie_id])
    party = Party.create(user_id: current_user.id,
                         movie_id: @movie.id,
                         date: params[:date],
                         time: params[:time],
                         duration: params[:duration_of_party])
    if party.save
      party.guests.create(user_id: current_user.id, attending: true)
      add_friends(party)
      redirect_to '/dashboard'
    else
      flash[:error] = party.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def add_friends(party)
    current_user.friends.each do |friend|
      if params[:"friend-#{friend.id}"] == '1'
        party.guests.create(user_id: friend.id, attending: false)
      end
    end
  end
end
