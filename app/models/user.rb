class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :email, presence: true, uniqueness: true
  # validates :phone_number, presence: true, length: { minimum: 9, maximum: 20 }
  # validates :card_number, presence: true, uniqueness: true, length: { is: 16 } 
  # validates :card_expiration, presence: true
  # validate :card_expiration_cannot_be_in_the_past
  enum role: %i[user admin]

  # def card_expiration_cannot_be_in_the_past
  #   if card_expiration.present? && card_expiration < (Date.today + 30)
  #     errors.add(:card_expiration, 'should be bigger than date of next month')
  #   end
  # end
end
