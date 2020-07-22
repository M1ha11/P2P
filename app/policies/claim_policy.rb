class ClaimPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if admin?
        scope.all
      elsif user?
        claims = scope.includes(:loan_participants)
        claims.where(status: 'publicly').or(claims.where(user_id: user.id).where.not(status: 'publicly'))
              .or(claims.where(loan_participants: { user_id: user.id }))
      else
        scope.where(status: 'publicly')
      end
    end
  end

  def index?
    true
  end

  def new?
    user? || admin? && not_default_user?
  end

  def create?
    belongs_to_user? && not_default_user?
  end

  def can_see_participants?
    user.present? && not_default_user?
  end

  def confirm?
    belongs_to_user? && not_default_user?
  end

  def statistic?
    admin?
  end

  def destroy?
    belongs_to_user? || admin?
  end

  def doesnt_belong_to_user?
    user.present? && !belongs_to_user? && not_default_user?
  end

  def show?
    true
  end

  def not_already_participant?
    !claim.loan_participants.find_by(user_id: user.id)
  end

  private

  def claim
    record
  end
end
