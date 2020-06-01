class CardPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user_id: user.id)
    end
  end

  def index?
    true
  end

  def create?
    true
  end

  def new?
    true
  end

  def destroy?
    belongs_to_user?
  end

  private

  def card
    record
  end
end
