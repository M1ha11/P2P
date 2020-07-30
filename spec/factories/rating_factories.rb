FactoryBot.define do
  factory :rating do
    rate { rand(1..5) }
    association :ratable, factory: [:claim, :claim_with_user]
    association :reviewed, factory: :user
  end
end
