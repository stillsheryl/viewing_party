class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email])
    if !user.nil? && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = 'Login Successful!'
      redirect_to dashboard_path
    else
      error_message
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:success] = 'Logout Successful!'
    redirect_to root_path
  end

  private

  def error_message
    flash[:error] = if params[:password].blank? && params[:email].blank?
                      'Fields cannot be blank.'
                    else
                      'Invalid email or password.'
                    end
    redirect_to root_path
  end
end
