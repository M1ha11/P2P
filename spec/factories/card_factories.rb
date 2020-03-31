FactoryBot.define do
  factory :card do
    card_number { '1111 1111 1111 1111' }
    expire_date { Faker::Date.between(from: 3.month.from_now, to: 2.year.from_now).strftime('%m/%Y') }
    user
  end
end
