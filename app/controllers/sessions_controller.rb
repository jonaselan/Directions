class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    # authenticate is a method from 'has_secure_password'
    uu = AttemptLoginFailed.where(email: params[:email], ip: request.remote_ip, attempt_time: nil).first_or_create
    if user && user.authenticate(params[:password])
      set_auth_token user
      uu.update(count: 0)
      redirect_to root_url; flash[:success] = 'Logged in!'
    else
      if uu.count == 3
        # timeout of 30 minutes
        uu.update(count: 0)
        uu.update(attempt_time: DateTime.now)
      else
        if uu.created_at < 10.minutes.ago
          uu.count = uu.count + 1
        else
          flash[:danger] = I18n.t 'application.invalid_infos'
          render 'new'
        end
      end
    end
  end

  def destroy
    cookies.delete(:auth_token)
    redirect_to root_url; flash[:success] = I18n.t 'application.logout'
  end

  private

  def set_auth_token(user)
    if params[:remember_me]
      cookies.permanent[:auth_token] = user.auth_token
    else
      cookies[:auth_token] = user.auth_token
    end
  end
end
