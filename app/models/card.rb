class Card < ApplicationRecord
  validates :card_number, presence: true, length: 16, numericality: true
  validates :expire_date, presence: true

  belongs_to :user
end
