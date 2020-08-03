FactoryBot.define do
  factory :claim do
    amount { Faker::Number.within(range: 100..1000) }
    currency { Faker::Currency.code }
    goal { Faker::Lorem.sentence }
    interest_rate { Faker::Number.decimal(l_digits: 1, r_digits: 2) }
    repayment_period { Claim.repayment_periods.values.last }
    payment_frequency { Claim.payment_frequencies.values.first }
    status { 'publicly' }

    trait :claim_with_tag do
      after :create do |claim|
        create :tagging, taggable: claim
      end
    end

    trait :claim_with_loan_participant do
      after :create do |claim|
        create :loan_participant, claim: claim
      end
    end

    trait :claim_with_user do
      association :user, factory: :user
    end
  end
end
