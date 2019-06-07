class SessionsController < ApplicationController
  def login
    @user = User.new
  end

  def create
    @user = User.find_by(username: params[:user][:username])

    if @user && @user.authenticate(params[:user][:password])
      log_in(@user)
      redirect_to wines_path
    else
      redirect_to '/sessions/login'
    end
  end

  def destroy
    logout
  end

  def googleAuth
    # Get access tokens from the google server
    access_token = request.env["omniauth.auth"]
    user = User.from_omniauth(access_token)
    # Access_token is used to authenticate request made from the rails application to the google server
    user.google_token = access_token.credentials.token
    # Refresh_token to request new access_token
    # Note: Refresh_token is only sent once during the first request
    refresh_token = access_token.credentials.refresh_token
    user.google_refresh_token = refresh_token if refresh_token.present?
    if User.exists?(username: user.username)
      user = User.find_by(username: user.username)
    else
      user.save
    end
    log_in(user)
    redirect_to wines_path
  end

end
