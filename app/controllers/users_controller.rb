class UsersController < ApplicationController
  def index 
    @users = User.all
    @title = "The Break Room"
  end

  def show
    @post = Post.new
    @user = User.find params[:id]
    @posts = Post.where("user_id = ?", @user[:id])
    @title = "Profile: " + @user.username
  end

  def new
    @user = User.new
    @title = "Sign Up"
  end

  def create
    @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        flash[:alert] = "Your profile has been created"
        redirect_to posts_path
      else
        flash[:alert] = "Something went wrong. Please check error message:"
        render :new
      end
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find(params[:id])
    if @user == current_user
    @user.update_attributes user_params
    redirect_to user_path(@user)
    else
      flash[:alert] = "You do not have permission to edit this account"
    redirect_to posts_path
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:alert] = "Your account has been deleted"
    session[:user_id] = nil
    redirect_to root_path
  end


  private

  def user_params
    params.require(:user).permit(:id, :username, :password, :password_confirmation, :city, :interests, :occupation, :avatar)
  end
 
end
  