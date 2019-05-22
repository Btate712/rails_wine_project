class SessionsController < ApplicationController
  def login
    @user = User.new
  end

  def create
    @user = User.find_by(username: params[:user][:username])
    if @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to wines_path
    else
      render '/sessions/login'
    end
  end
end
