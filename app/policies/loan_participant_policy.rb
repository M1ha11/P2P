class LoanParticipantPolicy < ApplicationPolicy
  def create?
    user_not_locked? && not_exists?
  end

  def destroy?
    admin? || user || claim_owner?
  end

  private

  def participant
    record
  end

  def user_not_locked?
    !user.access_locked?
  end

    def not_exists?
    participant.user != user
  end

  def claim_owner?
    participant.claim.user
  end
end