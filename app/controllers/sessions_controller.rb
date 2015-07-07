class SessionsController < ApplicationController

  def destroy
    session[:user_id] = nil
    flash[:alert] = "Successfully Logged Out"
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
        #success case
        session[:user_id] = @user.user_id
        redirect_to root_path
        flash[:alert] = "Welcome!"
      else
        #wrong password case
        flash[:alert] = "Your credentials don't match"
        redirect_to root_path
      end
    end

  end

end
