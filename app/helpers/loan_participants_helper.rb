module LoanParticipantsHelper
  def not_collected_amount_of_money?
    @claim.loan_participants.sum(:money) < @claim.amount
  end

  def loan_participant_avatar(loan_participant)
    if loan_participant.user.profile.avatar.attached?
      loan_participant.user.profile.avatar
    else
      '/avatar/avatar.png'
    end
  end
end