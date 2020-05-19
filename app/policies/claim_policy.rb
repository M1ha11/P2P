class ClaimPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if admin?
        scope.all
      elsif user?
        scope.where(status: 'publicly').or(scope.where(user_id: user.id).where.not(status: 'publicly'))
      else
        scope.where(status: 'publicly')
      end
    end
  end

  def index?
    true
  end

  def new?
    user? || admin?
  end

  def create?
    belongs_to_user?(claim)
  end

  def edit?
    belongs_to_user?(claim) || admin? && not_complete_or_archive
  end

  def update?
    belongs_to_user?(claim) || admin? && not_complete_or_archive
  end

  def destroy?
    belongs_to_user?(claim) || admin?
  end

  def show?
    if not_complete_or_archive
      true
    else
      belongs_to_user?(claim) || admin?
    end
  end

  private

  def claim
    record
  end

  def not_complete_or_archive
    claim.status != 'completed' || claim.status != 'archive'
  end
end
