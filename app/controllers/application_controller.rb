class ApplicationController < ActionController::Base

  def root
  end

  helper_method :current_user, :log_in

  def current_user
    @current_user ||= session[:user_id]
  end

  def log_in(user)
    session[:user_id] = user.id
  end
end
