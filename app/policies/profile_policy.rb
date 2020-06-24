class ProfilePolicy < ApplicationPolicy
  def show?
    belongs_to_user? || admin?
  end

  def update?
    belongs_to_user?
  end

  def edit?
    belongs_to_user?
  end

  private

  def profile
    record
  end
end
