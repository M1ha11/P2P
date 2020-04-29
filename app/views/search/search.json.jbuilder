json.claims do
  json.array(@claims) do |claim|
    json.amount claim.amount
    json.currency claim.currency
    json.goal claim.goal
    # json.interest_rate claim.interest_rate
    # json.repayment_period claim.repayment_period
    # json.payment_frequency claim.payment_frequency
    json.user_id claim.user_id
  end
end
