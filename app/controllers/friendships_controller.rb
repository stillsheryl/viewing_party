class FriendshipsController < ApplicationController
  def create
    friend = User.find_by(email: params[:email])
    if friend.nil? || current_user.friends.include?(friend)
      error_message(friend)
    else
      Friendship.create(user_id: current_user.id, friend_id: friend.id)



      recipient = friend.email

      email_info = {
      user: current_user,
      friend: friend.first_name,
      # message: @advice.message
    }

    FriendNotifierMailer.inform(email_info, recipient).deliver_now
    flash[:notice] = "We let #{friend.first_name} know that you added them as a friend."
    # redirect_to advice_url


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
