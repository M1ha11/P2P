class LoanParticipantPolicy < ApplicationPolicy
  def create?
    user? && user_not_locked?
  end

  def destroy?
    admin? || belongs_to_user? || claim_owner?
  end

  def user_is_participant?
    participant.user == user
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
