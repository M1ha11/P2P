class ClaimPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if admin?
        scope.all
      elsif user?
        scope.where(status: 'publicly') + scope.where(user_id: user.id)
      elsif user.blank? || user.nil? || !user
        scope.where(status: 'publicly')
      end
    end

    def user_claims
      scope.where(user_id: user.id)
    end
  end

  def index?
    true
  end

  def new?
    true
  end

  def create?
    belongs_to_user?(claim)
  end

  def edit?
    belongs_to_user?(claim) || admin?
  end

  def update?
    belongs_to_user?(claim) || admin?
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