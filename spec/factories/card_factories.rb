FactoryBot.define do
  factory :card do
    card_number { Faker::Stripe.valid_card }
    expire_date { Faker::Date.between(from: 3.month.from_now, to: 2.year.from_now).strftime('%m/%Y') }
    user { User.find(1..2) }
  end
end
