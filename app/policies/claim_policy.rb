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
    belongs_to_user?(claim)
  end

  def update?
    belongs_to_user?(claim)
  end

  def destroy?
    belongs_to_user?(claim) || admin?
  end

  def show?
    true
  end

  private

  def claim
    record
  end
end
