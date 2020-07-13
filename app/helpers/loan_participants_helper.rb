module LoanParticipantsHelper
  PERCENT = 100.0
  MONTHES = 12.0
  HALF_A_MONTH = 0.5

  def loan_participant_avatar(loan_participant)
    if loan_participant.profile.avatar.attached?
      loan_participant.profile.avatar
    else
      '/avatar/avatar.png'
    end
  end

  def income(loan_participant)
    rate = (loan_participant.claim.interest_rate.to_f / (PERCENT * MONTHES))
    month = claim_repayment_period(loan_participant)
    month = 1 if month < 1
    (loan_participant.money * (rate + (rate / (((1 + rate)**month) - 1))) - loan_participant.money).round(2)
  end

  def claim_initial_status?(participant)
    participant.claim.publicly? || participant.claim.privatly?
  end

  private

  def claim_repayment_period(loan_participant)
    if loan_participant.claim.repayment_period == '2 week'
      HALF_A_MONTH
    else
      loan_participant.claim.repayment_period_value.split(/\.(?=[^.]*$)/).first.to_f
    end
  end
end
