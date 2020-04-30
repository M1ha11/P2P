class LoanParticipant < ApplicationRecord
  belongs_to :user
  belongs_to :claim

  validates :money, presence: true, numericality: true
end
