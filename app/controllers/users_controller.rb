class UsersController < ApplicationController
  def index 
    @users = User.all
  end

  def show
    @user = User.find params[:id]
    @posts = Post.where("user_id = ?", @user[:id])
  end

  def new
    @user = User.new
  end

  def create
    if params[:user][:password] == params[:password_confirmation]
      @user = User.create user_params
      flash[:alert] = "Your profile has been created"
      @user.save
      redirect_to posts_path
    else
      flash[:alert] = "Your password and confirmation did not match."
      redirect_to users_path
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:alert] = "Your account has been deleted"
    redirect_to users_path
  end


  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :city, :interests)
  end


  
end
  