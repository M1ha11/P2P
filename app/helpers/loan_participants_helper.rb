module LoanParticipantsHelper
  def not_collected_amount_of_money?
    return true if @claim.loan_participants.sum(:money) < @claim.amount
    return false
  end
end