# == Schema Information
#
# Table name: claims
#
#  id                :bigint           not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  amount            :float            not null
#  currency          :string           not null
#  goal              :string           not null
#  interest_rate     :float            not null
#  repayment_period  :string           not null
#  payment_frequency :string           not null
#  status            :integer          default("0"), not null
#  user_id           :bigint           not null
#
class Claim < ApplicationRecord
  belongs_to :user
  has_many :tagging, as: :taggable
  has_many :tags, through: :tagging
  has_many :comments, as: :commentable, dependent: :destroy

  enum status: %i[publicly privatly archive]
  enum payment_frequency: { 'twice a month': 'twice a month', 'once a month': 'once a month',
                            'once a 3 month': 'once a 3 month', 'once a 4 month': 'once a 4 month',
                            'once a 6 month': 'once a 6 month', 'once a year': 'once a year' }
  enum repayment_period: { '2 week': '0.5.month', '1 month': '1.month', '3 month': '3.month',
                           '6 month': '6.month', '1 year': '12.month', 'year and a half': '18.month',
                           '2 years': '24.month', '3 years': '32.month', '5 years': '60.month',
                           '7 years': '84.month', '10 years': '120.month', '15 years': '180.month',
                           '20 years': '240.month' }

  validates :amount, presence: true, numericality: true
  validates :currency, presence: true
  validates :goal, presence: true
  validates :interest_rate, presence: true
  validates :repayment_period, presence: true
  validates :payment_frequency, presence: true
end
