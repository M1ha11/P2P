FactoryBot.define do
  factory :card do
    card_number { '4916 0801 3939 8504' }
    expire_date { Faker::Date.between(from: 3.month.from_now, to: 2.year.from_now).strftime('%m/%Y') }
  end
end
