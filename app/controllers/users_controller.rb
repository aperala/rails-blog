class UsersController < ApplicationController

  def index 
    @users = User.all
    @title = "The Staff Room"
  end

  # show page is 'profile' page, includes user's own posts and short form to create
  # new post. Set instance variables for all three.
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

  # new user sign-up page, log in after successful sign up (validations in model)
  # else give flash alert and render AR error message
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

  # edit form on show page (user profile)
  def edit
    @user = User.find params[:id]
  end

  # allow update of user profile only if current user matches user id
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

  # destroy user - delete account (will also delete assoc. posts and comments)
  # clear session and redirect to root
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:alert] = "Your account has been deleted"
    session.clear
    redirect_to root_path
  end


  # strong params for user
  private

  def user_params
    params.require(:user).permit(:id, :username, :password, :password_confirmation, :city, :interests, :occupation, :avatar)
  end
 
end
  