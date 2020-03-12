class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true
  validates :phone_number, presence: true
  validates :card_number, presence: true
  validates :card_expiration, presence: true

  enum role: %i[user admin]
  validates :role, inclusion: { in: %i[user admin] }
end
