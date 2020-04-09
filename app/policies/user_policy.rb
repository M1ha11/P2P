class UserPolicy < ApplicationPolicy
  def index?
    admin?
  end

  def lock?
    admin?
  end

  def unlock?
    admin?
  end
end