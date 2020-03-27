class Card < ApplicationRecord
  belongs_to :user
  before_save :encrypt

  validates :card_number, presence: true, length: {is: 19}, format: { with: /\A(\d{4})\s(\d{4})\s(\d{4})\s(\d{4})\z/ }
  validates :expire_date, presence: true, format: { with: /\d{2}\/\d{4}/ }
  validate :validate_expire

  def validate_expire
    if expire_date.present? && !Date.parse(expire_date).strftime('%m/%Y')
      errors.add(:expire_date, 'invalid date format')
    end
  end

  def encrypt
    JWt.encode(expire_date, ENV['TOKEN'], 'HS256')
  end
end
