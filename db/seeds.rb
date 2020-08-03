# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'factory_bot_rails'

3.times do
  FactoryBot.create(:user, :user_with_cards, :user_with_claims, :user_with_comments)

  Claim.create([
    {
      created_at: Time.zone.today - 15.days,
      amount: 666,
      currency: 'BYN',
      goal: 'For new car',
      interest_rate: 8.0,
      repayment_period: Claim.repayment_periods.values.last,
      payment_frequency: Claim.payment_frequencies.values.first,
      user: User.first,
      status: 'publicly'
    },
    {
      created_at: Time.zone.today - 15.days,
      amount: 666,
      currency: 'BYN',
      goal: 'For new car',
      interest_rate: 8.0,
      repayment_period: '6 month',
      payment_frequency: Claim.payment_frequencies.values.first,
      user: User.first,
      status: 'confirmed',
      confirmed_at: Time.zone.today - 13.days
    },
    {
      created_at: Time.zone.today - 6.months - 1.day,
      amount: 666,
      currency: 'BYN',
      goal: 'For new car',
      interest_rate: 8.0,
      repayment_period: '6 month',
      payment_frequency: Claim.payment_frequencies.values.first,
      user: User.first,
      status: 'confirmed',
      confirmed_at: Time.zone.today - 6.months - 1.day
    }
  ])
end