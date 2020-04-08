class ProfilePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user == scope.user || user.admin?
        scope.user.claims
      end
    end
  end

  def show?
    profile.user == user || user.admin?
  end

  def update?
    profile.user == user
  end

  def edit?
    profile.user == user
  end

  private

  def profile
    record
  end
end
