class LoanParticipantMoneyValidator < ActiveModel::Validator
  def validate(loan_participant)
    return unless loan_participant.money.present?

    residual_amount = claim_amount(loan_participant) - avaliable_amount_of_money(loan_participant)
    return if loan_participant.money < residual_amount

    loan_participant.errors.add(:base, I18n.t('loan_participants.create.alert', residual_amount: residual_amount))
  end

  private

  def avaliable_amount_of_money(loan_participant)
    loan_participant.claim.loan_participants.sum(:money)
  end

  def claim_amount(loan_participant)
    loan_participant.claim.amount
  end
end
