class ApplicationController < ActionController::Base
  before_action :current_user, :logged_in?

  def root
  end

  helper_method :current_user, :log_in, :logged_in?

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def logged_in?
    @logged_in = !!current_user
  end
end
