FactoryBot.define do
  factory :comment do
    text { Faker::Lorem.sentence }
    association :commentable, factory: :claim
    # user
  end
end
