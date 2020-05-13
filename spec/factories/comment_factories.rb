FactoryBot.define do
  factory :comment do
    text { Faker::Lorem.sentences(number: 1) }
    user
    association :commentable, factory: :claim
  end
end
