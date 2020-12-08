class ViewingPartiesController < ApplicationController
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
      Guest.create(party_id: party[:id], user_id: current_user.id, attending: true)
      current_user.friends.each do |friend|
        if params[:"input#friend-#{friend.id}"] == '1'
          Guest.create(party_id: party[:id], user_id: friend.id, attending: false)
        end
      end
      redirect_to '/dashboard'
    else
      flash[:error] = party.errors.full_messages.to_sentence
      render :new
    end
  end
end
