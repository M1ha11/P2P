class TagPolicy < ApplicationPolicy
  def create?
    admin?
  end
end
