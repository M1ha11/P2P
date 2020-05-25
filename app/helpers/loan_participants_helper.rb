module LoanParticipantsHelper
  PERCENT = 100
  MONTHES = 12

  def loan_participant_avatar(loan_participant)
    if loan_participant.profile.avatar.attached?
      loan_participant.profile.avatar
    else
      '/avatar/avatar.png'
    end
  end

  def income(loan_participant)
    rate = (loan_participant.claim.interest_rate / (PERCENT * MONTHES))
    month = claim_repayment_period(loan_participant)
    month = 1 if month < 1
    (loan_participant.money * (rate + (rate / (((1 + rate) ^ month) - 1))) - loan_participant.money).round(2)
  end

  private

  def claim_repayment_period(loan_participant)
    loan_participant.claim.repayment_period.split(/\.(?=[^.]*$)/).first.to_f
  end
end
