class Claim < ApplicationRecord
  belongs_to :user

  validates :amount, presence: true, numericality: true
  validates :currency, presence: true
  validates :goal, presence: true
  validates :interest_rate, presence: true
  validates :repaiment_period, presence: true
  validates :payment_frequency, presence: true
  validates :status, inclusion: { in: %w[public private] }
end
