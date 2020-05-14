FactoryBot.define do
  factory :comment do
    text { Faker::Lorem.sentence }
    user
    association :commentable, factory: :claim
  end
end
