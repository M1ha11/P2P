class LoanParticipantPolicy < ApplicationPolicy
  def create?

  end

  def destroy?
  end

  private

  def participant
    record
  end

  def claim_not_belongs_to_you?
  end

  def exists?
    participant.user == user
  end
end