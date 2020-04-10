class ProfilePolicy < ApplicationPolicy
  def show?
    belongs_to_user?(profile) || admin?
  end

  def update?
    belongs_to_user?(profile)
  end

  def edit?
    belongs_to_user?(profile)
  end

  private

  def profile
    record
  end
end
