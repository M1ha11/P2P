FactoryBot.define do
  factory :rating do
    rate { rand(1..5) }
    association :ratable, factory: :claim
    association :reviewed, factory: :user
  end
end
