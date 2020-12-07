class FriendshipsController < ApplicationController
  def create
    friend = User.find_by(email: params[:email])
    unless friend.nil?
      friendship = Friendship.find_by(user_id: current_user.id, friend_id: friend.id)
    end
    if friend.nil?
      flash[:error] = "I'm sorry your friend cannot not found."
    elsif friendship.nil?
      Friendship.create(user_id: current_user.id, friend_id: friend.id)
    elsif !friendship.nil?
      flash[:error] = 'You are already friends.'
    end
    redirect_to '/dashboard'
  end
end
