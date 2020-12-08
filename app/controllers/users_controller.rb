class UsersController < ApplicationController
  def new
    @user = User.new(user_params)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id


      # email_info = {
      # user: @user,
      # friend: params[:friends_name],
      # message: @advice.message
    # }
      # UserMailer.with(user: @user).welcome_email(email_info, @user.email).deliver_now

      # UserMailer.welcome_email(email_info, @user.email).deliver_now


      flash[:notice] = "Your account has successfully been created, #{@user.first_name}."
      redirect_to '/dashboard'
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
