class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url; flash[:success] = "Signed up!"
    else
      render "new"
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to root_path; flash[:success] = 'User was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

private
  def set_user
    @user = User.find current_user.id
  end

  def user_params
    params.require(:user).permit(:email, :username,
                                 :password, :password_confirmation)
  end
end
