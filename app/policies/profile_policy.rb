class ProfilePolicy < ApplicationPolicy
  def show?
    user.present? && profile.user == user || user.admin?
  end

  def update?
    user.present? && profile.user == user
  end

  def edit?
    user.present? && profile.user == user
  end

  private

  def profile
    record
  end
end
