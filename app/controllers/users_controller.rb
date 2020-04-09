class UsersController < ApplicationController
  def index
    @users = policy_scope(User)
    respond_with @users, location: -> { users_path }
  end

  def lock
    user.lock_access!({ send_instructions: false })
    respond_with user, location: -> { users_path }
  end

  def unlock
    user.unlock_access!
    respond_with user, location: -> { users_path }
  end

  def make_admin
  end

  private

  def user
    @user ||= User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :role)
  end
end
