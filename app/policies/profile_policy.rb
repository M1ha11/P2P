class ProfilePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user == scope.user || admin?
        scope.user.claims
      end
    end
  end

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
