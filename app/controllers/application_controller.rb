class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def authenticate
    redirect_to login_path unless session[:user_id]
  end

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
