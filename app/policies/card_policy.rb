class CardPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.present?
        scope.where(user_id: user.id)
      end
    end
  end

  def index?
    user.present?
  end

  def create?
    user.present?
  end

  def destroy?
    user.present? && card.user == user
  end

  private

  def card
    record
  end
end
