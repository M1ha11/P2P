class CardPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user_id: user.id)
    end
  end

  def index?
    user? || admin? && not_default_user?
  end

  def create?
    user? || admin? && not_default_user?
  end

  def new?
    user? || admin? && not_default_user?
  end

  def destroy?
    belongs_to_user? && not_default_user?
  end

  private

  def card
    record
  end
end
