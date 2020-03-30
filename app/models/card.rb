class Card < ApplicationRecord
  before_save :encrypt!
  before_save :remove_spaces!

  belongs_to :user

  validates :card_number, presence: true, format: { with: /\A(\d{16})\z/ }
  validates :expire_date, presence: true, format: { with: %r/\d{2}\/\d{4}/ }
  validate :validate_expire

  private

  def validate_expire
    if expire_date.present? && !Date.parse(expire_date).strftime('%m/%Y')
      errors.add(:expire_date, 'invalid date format')
    end
  end

  def encrypt!
    self.expire_date = JWT.encode(expire_date, ENV['TOKEN'], 'HS256')
  end

  def remove_spaces!
    self.card_number.gsub!(' ', '')
  end
end
