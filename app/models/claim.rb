# == Schema Information
#
# Table name: claims
#
#  id                :bigint           not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  amount            :float            not null
#  currency          :string           not null
#  goal              :string           not null
#  interest_rate     :float            not null
#  repayment_period  :string           not null
#  payment_frequency :string           not null
#  status            :integer          default("0"), not null
#  user_id           :bigint           not null
#
class Claim < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  include AASM

  enum status: { publicly: 'publicly', privatly: 'privatly', archived: 'archived',
                 confirmed: 'confirmed', successful: 'successful' }
  enum payment_frequency: { 'twice a month': '0.5.month', 'once a month': '1.month',
                            'once a 3 month': '3.month', 'once a 4 month': '4.month',
                            'once a 6 month': '6.month', 'once a year': '12.month' }
  enum repayment_period: { '2 week': '0.5.month', '1 month': '1.month', '3 month': '3.month',
                           '6 month': '6.month', '1 year': '12.month', 'year and a half': '18.month',
                           '2 years': '24.month', '3 years': '32.month', '5 years': '60.month',
                           '7 years': '84.month', '10 years': '120.month', '15 years': '180.month',
                           '20 years': '240.month' }

  validates :amount, presence: true, numericality: true
  validates :currency, presence: true
  validates :goal, presence: true
  validates :interest_rate, presence: true
  validates :repayment_period, presence: true
  validates :payment_frequency, presence: true

  aasm column: :status, enum: true do
    state :publicly, initial: true
    state :privatly, initial: true
    state :archived
    state :confirmed
    state :successfull

    event :archive do
      transitions from: %i[publicly privatly], to: :archived
    end

    event :confirm do
      transitions from: %i[publicly privatly], to: :confirmed
    end

    event :success do
      transitions from: :confirmed, to: :successfull, after: :update_users_projects_statistics
    end
  end

  def repayment_period_value
    Claim.repayment_periods[repayment_period]
  end

  def payment_frequency_value
    Claim.payment_frequencies[payment_frequency]
  end

  private

  def update_users_projects_statistics
    ActiveRecord::Base.transaction do
      self.user.profile.update(success_credit_project: self.user.profile.success_credit_project + 1)
      self.loan_participants.find_each do |participant|
        participant.user.profile.update(success_lend_project: participant.user.profile.success_lend_project + 1)
      end
    end
  end
end
