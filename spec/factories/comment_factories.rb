FactoryBot.define do
  factory :comment do
    text { Faker::Lorem.sentences(number: 1) }
    user
    claim
  end
end
