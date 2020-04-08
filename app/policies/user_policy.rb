class UserPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def lock?
    user.admin?
  end

  def unlock?
    user.admin?
  end
end