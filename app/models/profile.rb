# == Schema Information
#
# Table name: profiles
#
#  id                     :bigint           not null, primary key
#  success_credit_project :integer          default("0")
#  success_lend_project   :integer          default("0")
#  phone_number           :string(25)       not null
#  address                :string(150)      not null
#  avatar                 :string
#  user_id                :bigint           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  locale                 :string(10)       default("en"), not null
#
class Profile < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :claims, through: :user

  has_one_attached :avatar
  accepts_nested_attributes_for :user

  validates :phone_number, presence: true, length: { minimum: 10, maximum: 25 },
                           format: {
                             with: /\A(?:\+?\d{1,3}\s*-?)?\(?(?:\d{2,3})?\)?[- ]?\d{3,4}[- ]?\d{4}\z/
                           }
  validates :address, presence: true, length: { maximum: 150 }
  validates :success_credit_project, numericality: true
  validates :success_lend_project, numericality: true
end
