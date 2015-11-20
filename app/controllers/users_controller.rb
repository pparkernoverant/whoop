class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action only: [:edit, :update] { require_self(@user) }

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      flash[:notice] = 'Your account has been created.'
      redirect_to root_path
    else
      flash.now[:error] = 'Your account has not been created.'
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = 'Your profile has been updated.'
      redirect_to user_path(@user)
    else
      flash.now[:error] = 'Your profile has not been updated.'
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :username)
  end

  def set_user
    @user = User.find_by id: params[:id]
  end
end