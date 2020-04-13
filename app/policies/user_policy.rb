class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where.not(id: user.id) if admin?
    end
  end

  def index?
    admin?
  end

  def lock?
    admin? && user_not_admin?
  end

  def unlock?
    admin? && user_not_admin?
  end

  def change_role?
    not_locked? && admin?
  end

  private

  def user_not_admin?
    return true unless record.admin?

    false
  end

  def not_locked?
    return true unless record.access_locked?

    false
  end
end
