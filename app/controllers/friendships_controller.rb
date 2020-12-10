class FriendshipsController < ApplicationController
  before_action :require_user

  def create
    friend = User.find_by(email: params[:email])
    if friend.nil? || current_user.friends.include?(friend)
      error_message(friend)
    else
      Friendship.create(user_id: current_user.id, friend_id: friend.id)
      send_email(friend)
    end
    redirect_to dashboard_path
  end

  private

  def error_message(friend)
    if friend.nil?
      flash[:error] = "I'm sorry your friend cannot not found."
    elsif current_user.friends.include?(friend)
      flash[:error] = 'You are already friends.'
    end
  end

  def send_email(friend)
    recipient = friend.email

    email_info = {
      user: current_user,
      friend: friend.first_name
    }

    FriendNotifierMailer.inform(email_info, recipient).deliver_now
    flash[:notice] = "We let #{friend.first_name} know that you added them as a friend."
  end
end
