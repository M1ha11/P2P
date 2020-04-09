class ClaimPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if admin?
        scope.all
      elsif user?
        scope.where(status: 'publicly')
      elsif user.blank? || user.nil? || !user
        scope.where(status: 'publicly')
      end
    end

    def user_claims
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