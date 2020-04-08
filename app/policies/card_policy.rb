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

  def destroy?
    card.user == user
  end

  private

  def card
    record
  end
end
