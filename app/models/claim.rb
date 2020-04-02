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

  enum status: %i[public private archive], _scope_prefix: true
  enum repaiment_period: ['0.5 month', '1 month', '3 month', '6 month', '12 month', '18 month', '24 month',
                          '32 month', '60 month', '84 month', '120 month', '180 month', '240 month']
  enum payment_frequency: ['twice a month', 'once a month', 'once a 3 month', 'once a 4 month',
                           'once a 6 month', 'once a year']
  
  validates :amount, presence: true, numericality: true
  validates :currency, presence: true
  validates :goal, presence: true
  validates :interest_rate, presence: true
  validates :repaiment_period, presence: true
  validates :payment_frequency, presence: true
end
