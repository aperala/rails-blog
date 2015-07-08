class UsersController < ApplicationController
  def index 
    @users = User.all
  end

  def show
    @user = User.find params[:id]
  end

  def new
    @user = User.new
  end

  def create
    if params[:user][:password] == params[:password_confirmation]
      @user = User.create params[:user]
      flash[:alert] = "Your profile has been created"
      redirect_to users_path
    else
      flash[:alert] = "Your password and confirmation did not match."
      redirect_to users_path
    end
  end

end
  