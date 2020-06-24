# == Schema Information
#
# Table name: loan_participants
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#  claim_id   :bigint
#  money      :float
#
class LoanParticipant < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :claim, dependent: :destroy
  has_one :profile, through: :user

  delegate :success_credit_project, to: :profile
  delegate :success_lend_project, to: :profile

  validates_with LoanParticipantMoneyValidator
  validates :money, presence: true, numericality: true
end
