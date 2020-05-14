class TaggingPolicy < ApplicationPolicy
  def destroy?
    admin?
  end
end
