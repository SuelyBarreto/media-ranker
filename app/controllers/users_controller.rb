class UsersController < ApplicationController

  def login_form
    @user = User.new
  end

  def login
    name = params[:user][:name]
    user = User.find_by(name: name)
    if user
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as returning user #{name}"
    else
      user = User.create(name: name, joined: Date.today)
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as new user #{name}"
    end
  
    redirect_to root_path
    return
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
  
    redirect_to root_path
    return
  end

end
