class UsersController < ApplicationController
  def new
    @user = User.new(user_params)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id

      send_welcome_email(@user)

      flash[:notice] = "Your account has successfully been created, #{@user.first_name}."
      redirect_to dashboard_path
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def send_welcome_email(user)
    email_info = { user: user }

    UserMailer.welcome_email(email_info, user.email).deliver_now
  end
end
