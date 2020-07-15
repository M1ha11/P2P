FactoryBot.define do
  factory :rating do
    rate { Faker::Number.between(from: 1, to: 5) }
    association :ratable, factory: :claim
    association :reviewed, factory: :user
  end
end
