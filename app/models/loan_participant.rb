class LoanParticipant < ApplicationRecord
  belongs_to :user
  belongs_to :claim
  has_one :profile, through: :user

  delegate :success_credit_project, to: :profile
  delegate :success_lend_project, to: :profile

  validates_with LoanParticipantMoneyValidator
  validates :money, presence: true, numericality: true
end
