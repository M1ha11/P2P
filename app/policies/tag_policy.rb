class TagPolicy < ApplicationPolicy
  def create?
    admin? && not_default_user?
  end
end
