class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if admin?
        scope.where.not(id: user.id)
      else
        scope.none
      end
    end
  end

  def index?
    admin?
  end

  def lock?
    admin? && editable_user_not_admin? && editable_user_not_locked?
  end

  def unlock?
    admin? && editable_user_not_admin? && editable_user_locked?
  end

  def change_role?
    editable_user_not_locked? && admin?
  end

  def editable_user_not_admin?
    !record.admin?
  end

  def editable_user_not_locked?
    !record.access_locked?
  end

  def editable_user_locked?
    record.access_locked?
  end
end
