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
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class Profile < ApplicationRecord
  validates :phone_number, presence: true, length: { minimum: 10, maximum: 25 }
  validates :address, presence: true

  has_one_attached :avatar
  belongs_to :user
end
