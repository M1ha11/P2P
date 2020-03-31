FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    role { rand(0..1) }
    password { '123456' }
    confirmed_at { Time.now.utc }
  end
end
