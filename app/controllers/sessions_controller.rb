class SessionsController < ApplicationController
  layout 'session'

  def new; end

  def create
    @current_user = begin
      User.from_omniauth(oauth_params) || User.create_from_omniauth(oauth_params)
    end

    if @current_user
      session[:user_id] = @current_user.id
      redirect_to root_url, :notice => 'Signed in!'
    else
      redirect_to login_path, :alert => 'You are not authorized to access this page'
    end
  end

  private

  def oauth_params
    env['omniauth.auth']
  end

end
