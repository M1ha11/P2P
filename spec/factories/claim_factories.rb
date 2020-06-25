FactoryBot.define do
  factory :claim do
    amount { Faker::Number.within(range: 100..1000) }
    currency { Faker::Currency.code }
    goal { Faker::Lorem.sentence }
    interest_rate { Faker::Number.decimal(l_digits: 1, r_digits: 2) }
    repayment_period { Claim.repayment_periods.values.sample }
    payment_frequency { Claim.payment_frequencies.values.sample }
    status { 'publicly' }
    user
    # after :create do |claim|
    #   create :tagging, taggable: claim
    #   create :loan_participant, claim: claim
    # end
  end
end
