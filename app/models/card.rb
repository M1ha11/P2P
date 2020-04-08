# == Schema Information
#
# Table name: cards
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  card_number :string(19)       not null
#  expire_date :string           not null
#  user_id     :bigint           not null
#
class Card < ApplicationRecord
  before_save :encrypt!
  before_save :remove_spaces!

  belongs_to :user

  validates_with CardDateValidator
  validates :card_number, presence: true, format: { with: /\A(\d{4}\s\d{4}\s\d{4}\s\d{4})\z/ }
  validates :expire_date, presence: true, format: { with: %r/\d{2}\/\d{4}/ }

  private

  def encrypt!
    self.expire_date = JWT.encode(expire_date, ENV['TOKEN'], 'HS256')
  end

  def remove_spaces!
    self.card_number.gsub!(' ', '')
  end
end
