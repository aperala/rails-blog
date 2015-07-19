class SessionsController < ApplicationController
 
 # clear session after user logout and redirect to root
  def destroy
    session.clear
    redirect_to root_path
  end

  # initiate session: find user by username, then match password
  # set session user id to @user to log in after validation
  def create
    username = params[:username]
    password = params[:password]
 
    @user = User.where(username: username).first

    if @user.nil?
      #wrong username case
      flash[:alert] = "Incorrect credentials"
      redirect_to root_path
    else
      if @user.password == password
        session[:user_id] = @user.id
        redirect_to posts_path
      else
        #wrong password case
        flash[:alert] = "Your credentials don't match"
        redirect_to root_path
      end
    end

  end

end
