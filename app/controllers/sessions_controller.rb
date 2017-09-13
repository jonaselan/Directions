class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    # authenticate is a method from 'has_secure_password'
    if user && user.authenticate(params[:password])
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
      redirect_to root_url; flash[:success] = 'Logged in!'
    else
      flash[:danger] = I18n.t 'application.invalid_infos'
      render 'new'
    end
  end

  def destroy
    cookies.delete(:auth_token)
    redirect_to root_url; flash[:success] = I18n.t 'application.logout'
  end
end
