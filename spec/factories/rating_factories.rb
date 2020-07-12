FactoryBot.define do
  factory :rating do
    rate { Faker::Number.between(from: 1, to: 5) }
    reviewed_id { User.first.id }
  end
end
