class RatingPolicy < ApplicationPolicy
  def new?
    belongs_to_user? && not_default_user?
  end

  def create?
    belongs_to_user? && not_default_user?
  end
end
