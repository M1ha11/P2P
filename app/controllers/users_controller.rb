class UsersController < ApplicationController
  def index
    @users = policy_scope(User)
    respond_with @users, location: -> { users_path }
  end

  def lock
    user.lock_access!(send_instructions: false)
    respond_with user, location: -> { users_path }
  end

  def unlock
    user.unlock_access!
    respond_with user, location: -> { users_path }
  end

  def change_role
    user.update(user_params)
    respond_with user, location: -> { users_path }
  end

  private

  def user
    @user ||= begin
      user = User.find(params[:id])
      authorize user
    end
  end

  def user_params
    params.require(:user).permit(:role)
  end
end
