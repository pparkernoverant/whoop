class SessionsController < ApplicationController
  before_action :redirect_logged_in_user, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by username: session_params[:username]

    if user && user.authenticate(session_params[:password])
      session[:user_id] = user.id
      flash[:notice] = 'You have successfully logged in.'
      redirect_to root_path
    else
      flash[:error] = 'Invalid username or password.'
      redirect_to login_path
    end

  end

  def destroy
    flash[:notice] = 'You have successfully logged out.' if session[:user_id]
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def redirect_logged_in_user
    redirect_to root_path if current_user
  end

  def session_params
    params.require(:session).permit(:username, :password)
  end
end