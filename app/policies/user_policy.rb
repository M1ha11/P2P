class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.where.not(id: user.id)
      end
    end
  end

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