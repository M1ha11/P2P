class CardPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user_id: user.id)
    end
  end

  def index?
     user? || admin?
  end

  def create?
     user? || admin?
  end

  def new?
    user? || admin?
  end

  def destroy?
    belongs_to_user?(card)
  end

  private

  def card
    record
  end

  def user_exist?
    user.present?
  end
end
