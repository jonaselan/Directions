class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    # authenticate is a method from 'has_secure_password'
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url; flash[:success] = 'Logged in!'
    else
      flash[:danger] = I18n.t 'application.invalid_infos'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url; flash[:success] = I18n.t 'application.logout'
  end
end
