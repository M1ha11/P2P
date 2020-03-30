# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'factory_bot_rails'

User.create([
  {
    email: Faker::Internet.email,
    role: 'admin',
    password: '123456',
    confirmed_at: Time.now.utc
  },
  {
    email: Faker::Internet.email,
    role: 'user',
    password: '123456',
    confirmed_at: Time.now.utc
  },
  {
    email: Faker::Internet.email,
    role: 'user',
    password: '123456',
    confirmed_at: Time.now.utc
  }
])

Profile.create([
  {
    phone_number: Faker::PhoneNumber.cell_phone_with_country_code,
    address: Faker::Address.full_address,
    user: User.first
  },
  {
    phone_number: Faker::PhoneNumber.cell_phone_with_country_code,
    address: Faker::Address.full_address,
    user: User.second
  },
  {
    phone_number: Faker::PhoneNumber.cell_phone_with_country_code,
    address: Faker::Address.full_address,
    user: User.find(3)
  }
])

2.times do
  c = FactoryBot.build(:card)
  c.save!
end