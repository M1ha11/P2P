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

Card.create([
  {
    card_number: Faker::Number.number(digits: 16)
    expire_date: Faker::Date.between(from: 3.month.ago, to: 1.year.ago)
    user: User.first
  },
  {
    card_number: Faker::Number.number(digits: 16)
    expire_date: Faker::Date.between(from: 3.month.ago, to: 1.year.ago)
    user: User.second
  },
  {
    card_number: Faker::Number.number(digits: 16)
    expire_date: Faker::Date.between(from: 3.month.ago, to: 1.year.ago)
    user: User.find(3)
  }
])
