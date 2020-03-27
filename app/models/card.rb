class Card < ApplicationRecord
  belongs_to :user

  validates :card_number, presence: true, length: {is: 16}, numericality: true
  validates :expire_date, presence: true, format: { with: /\d{2}\/\d{4}/ }
  validate :validate_expire

  def validate_expire
    if expire_date.present? && Date.parse(expire_date).strftime('%m/%Y')
      Date.parse(expire_date).strftime('%m/%Y')
    else
      errors.add(:expire_date, 'invalid date format')
    end
  end

  def encrypt

  end
end
