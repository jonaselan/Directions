class PasswordResetsController < ApplicationController
  before_action :set_user_by_new_token, only: [:edit, :update]

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    redirect_to root_url; flash[:info] = "sim"
  end

  def edit
  end

  def update
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path; flash[:info] = "Password reset has experied"
    elsif @user.update_attributes(params[:user])
      redirect_to root_url; flash[:success] = "Password has been reset"
    else
      render :edit
    end
  end

  private

  def set_user_by_new_token
    @user = User.find_by_password_reset_token!(params[:id])
  end
end
