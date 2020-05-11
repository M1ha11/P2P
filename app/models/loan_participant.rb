class LoanParticipant < ApplicationRecord
  belongs_to :user
  belongs_to :claim

  validates_with LoanParticipantMoneyValidator
  validates :money, presence: true, numericality: true
end
