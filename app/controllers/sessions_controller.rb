class SessionsController < ApplicationController

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

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
        flash[:alert] = "Welcome!"
        redirect_to posts_path
      else
        #wrong password case
        flash[:alert] = "Your credentials don't match"
        redirect_to root_path
      end
    end

  end

end
