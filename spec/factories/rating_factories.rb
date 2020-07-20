FactoryBot.define do
  factory :rating do
    rate { (1..5).sample }
    association :ratable, factory: :claim
    association :reviewed, factory: :user
  end
end
