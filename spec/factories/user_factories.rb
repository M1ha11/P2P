FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    role { rand(0..1) }
    password { '123456' }
    confirmed_at { Time.now.utc }
    # after :create do |user|
    #   create :profile, user: user
    #   create_list :card, 1, user: user
    #   create_list :comment, 1, user: user
    #   create_list :claim, 1, user: user
    # end
  end
end
