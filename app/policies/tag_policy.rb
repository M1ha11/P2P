class TagPolicy < ApplicationPolicy
  def create?
    admin?
  end

  def destroy?
    admin?
  end
end
