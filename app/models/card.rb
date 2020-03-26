class Card < ApplicationRecord
  belongs_to :user

  validates :card_number, presence: true, length: 16, numericality: true
  validates :expire_date, presence: true
end
