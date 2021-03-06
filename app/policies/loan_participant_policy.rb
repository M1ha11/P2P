class LoanParticipantPolicy < ApplicationPolicy
  def create?
    user.present? && user_not_locked? && !claim_owner? && not_default_user?
  end

  def destroy?
    admin? || belongs_to_user? || claim_owner? && not_default_user?
  end

  private

  def participant
    record
  end

  def user_not_locked?
    !user.access_locked?
  end

  def claim_owner?
    participant.claim.user == user
  end
end
