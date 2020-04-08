class UsersController < ApplicationController
  def index
    @users = User.where.not(id: current_user.id)
    respond_with @users, location: -> { users_path }
  end

  def lock
    user.lock_access!({ send_instructions: false })
  end

  def unlock
    user.unlock_access!
  end

  def make_admin
  end

  private

  def user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :role)
  end
end
