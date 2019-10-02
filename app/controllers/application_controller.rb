class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private
  def require_signin
    unless current_user
      session[:intended_url] = request.url
      redirect_to signin_path, alert: "Please sign in first!"
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_user?(user)
    current_user == user
  end

  def current_user_admin?
    current_user && current_user.admin?
  end

  helper_method :current_user
  helper_method :current_user?
  helper_method :current_user_admin?
end
