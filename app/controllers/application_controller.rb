class ApplicationController < ActionController::Base

  def root
  end

  helper_method :current_user, :log_in, :logged_in?

  def current_user
    if session[:user_id]
      if session[:user_id]
        @current_user ||= User.find(session[:user_id])
      end
    end
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def logged_in?
    @logged_in = !!current_user
  end

  def require_login
    unless logged_in?
      flash[:error] = "Please log in to access the application"
      redirect_to root_path
    end
  end
end
