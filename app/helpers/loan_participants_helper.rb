module LoanParticipantsHelper
  def loan_participant_avatar(loan_participant)
    if loan_participant.user.profile.avatar.attached?
      loan_participant.user.profile.avatar
    else
      '/avatar/avatar.png'
    end
  end

  def income(loan_participant, claim)
    rate = (claim.interest_rate / 100 / 12)
    month = claim.repayment_period.split(/\.(?=[^.]*$)/)[0]
    income = (loan_participant.money * (rate + (rate / ((1 + rate) - 1))) - loan_participant.money).round(2)
    income
  end
end
