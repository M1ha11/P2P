class LoanParticipantMoneyValidator < ActiveModel::Validator
  def validate(loan_participant)
    return unless loan_participant.money.present?

    if loan_participant.money > claim_amount(loan_participant) - avaliable_amount_of_money(loan_participant)
      loan_participant.errors.add(:base, "You entered sum bigger than needed.
                                  Please enter #{claim_amount(loan_participant) - 
                                  avaliable_amount_of_money(loan_participant)}")
    end
  end

  private

  def avaliable_amount_of_money(loan_participant)
    loan_participant.claim.loan_participants.sum(:money)
  end

  def claim_amount(loan_participant)
    loan_participant.claim.amount
  end
end
