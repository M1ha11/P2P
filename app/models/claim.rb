# == Schema Information
#
# Table name: claims
#
#  id                :bigint           not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  amount            :float
#  currency          :integer
#  goal              :string
#  interest_rate     :float
#  repaiment_period  :integer
#  payment_frequency :integer
#  status            :integer
#
class Claim < ApplicationRecord
  belongs_to :user

  enum status: %w[public private archive]
  enum repaiment_period: ['2 week', '1 month']
  
  validates :amount, presence: true, numericality: true
  validates :currency, presence: true
  validates :goal, presence: true
  validates :interest_rate, presence: true
  validates :repaiment_period, presence: true
  validates :payment_frequency, presence: true
end
