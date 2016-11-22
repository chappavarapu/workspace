class UsersController < ApplicationController
  def update
    @user.update(user_params)
  end

  def create
    @user.create(user_params)
  end

  def destroy
    @user.destroy
  end 

  def new
    @user = User.new
  end

  private
  def user_params
    params.require(:user).permit(:password_digest, :username)
  end    
end
