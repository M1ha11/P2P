FactoryBot.define do
  factory :profile do
    phone_number { '+375 (11) 880 0555' }
    address { Faker::Address.full_address }
    # user
  end
end
