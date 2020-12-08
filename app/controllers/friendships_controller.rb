class FriendshipsController < ApplicationController
  before_action :require_user

  def create
    friend = User.find_by(email: params[:email])
    if friend.nil? || current_user.friends.include?(friend)
      error_message(friend)
    else
      Friendship.create(user_id: current_user.id, friend_id: friend.id)
    end
    redirect_to '/dashboard'
  end

  def error_message(friend)
    if friend.nil?
      flash[:error] = "I'm sorry your friend cannot not found."
    elsif current_user.friends.include?(friend)
      flash[:error] = 'You are already friends.'
    end
  end
end
