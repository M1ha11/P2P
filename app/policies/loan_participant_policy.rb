class LoanParticipantPolicy < ApplicationPolicy
  def create?
    user_not_locked? && exists?
  end

  def destroy?
    admin? || user || claim_owner? && claim_not_confirmed?
  end

  private

  def participant
    record
  end

  def user_not_locked?
    !user.access_locked?
  end

  def exists?
    user.present?
  end

  def claim_not_confirmed?
    participant.claim.status != 'confirmed'
  end

  def claim_owner?
    participant.claim.user
  end
end
