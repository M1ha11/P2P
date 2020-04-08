class ProfilePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user == scope.user || user.admin?
        scope.user.claims
      end
    end
  end

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
