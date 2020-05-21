class LoanParticipantMoneyValidator < ActiveModel::Validator
  def validate(loan_participant)
    return unless loan_participant.money.present?

    if loan_participant.money > loan_participant.claim.amount - loan_participant.claim.loan_participants.sum(:money)
      sum = loan_participant.claim.loan_participants.sum(:money)
      loan_participant.errors.add(:base, "You entered sum bigger than needed.
                                  Please enter #{loan_participant.claim.amount - sum}")
    end
  end
end
