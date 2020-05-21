module ClaimsHelper
  def not_collected_amount_of_money?
    @claim.loan_participants.sum(:money) < @claim.amount
  end

  def collected_amount?
    @claim.amount == @claim.loan_participants.sum(:money)
  end
end
