class RatingPolicy < ApplicationPolicy
  def new
    belongs_to_user?
  end

  def create
    belongs_to_user?
  end
end