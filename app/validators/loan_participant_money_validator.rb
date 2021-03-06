class LoanParticipantMoneyValidator < ActiveModel::Validator
  def validate(loan_participant)
    return unless loan_participant.money.present?

    claim = loan_participant.claim
    residual_amount = claim_amount(claim) - avaliable_amount_of_money(claim)
    return if loan_participant.money <= residual_amount

    loan_participant.errors.add(:base, I18n.t('activerecord.errors.messages.loan_participants.bigger_sum',
                                                          residual_amount: residual_amount))
  end

  private

  def avaliable_amount_of_money(claim)
    claim.loan_participants.sum(:money)
  end

  def claim_amount(claim)
    claim.amount
  end
end
