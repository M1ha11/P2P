FactoryBot.define do
  factory :profile do
    phone_number { Faker::PhoneNumber.cell_phone_with_country_code }
    address { Faker::Address.full_address }
    user
  end
end
