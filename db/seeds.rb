# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create([
  {
    email: Faker::Internet.email,
    phone_number: Faker::PhoneNumber.cell_phone_with_country_code,
    card_number: Faker::Number.number(digits: 16),
    card_expiration: Faker::Date.between(from: 3.month.from_now, to: 2.year.from_now),
    role: 'admin',
    password: '123456'
  },
  {
    email: Faker::Internet.email,
    phone_number: Faker::PhoneNumber.cell_phone_with_country_code,
    card_number: Faker::Number.number(digits: 16),
    card_expiration: Faker::Date.between(from: 3.month.from_now, to: 2.year.from_now),
    role: 'user',
    password: '123456'
  },
  {
    email: Faker::Internet.email,
    phone_number: Faker::PhoneNumber.cell_phone_with_country_code,
    card_number: Faker::Number.number(digits: 16),
    card_expiration: Faker::Date.between(from: 3.month.from_now, to: 2.year.from_now),
    role: 'user',
    password: '123456'
  }
])
