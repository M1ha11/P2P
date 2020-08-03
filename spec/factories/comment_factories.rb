FactoryBot.define do
  factory :comment do
    text { Faker::Lorem.sentence }
    association :commentable, factory: [:claim, :claim_with_user]
  end
end
