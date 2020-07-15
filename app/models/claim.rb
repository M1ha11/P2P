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
#  user_id           :bigint           not null
#  status            :string           default("publicly"), not null
#  confirmed_at      :datetime
#
class Claim < ApplicationRecord
  PER_PAGE = 18

  include Searchable
  include AASM

  belongs_to :user
  has_many :loan_participants, dependent: :destroy
  has_many :taggings, as: :taggable
  has_many :tags, -> { distinct }, through: :taggings
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :ratings, as: :ratable

  enum status: { publicly: 'publicly', privatly: 'privatly', archived: 'archived',
                 confirmed: 'confirmed', successfull: 'successfull' }

  enum payment_frequency: { 'twice a month': '0.5.month',
                            'once a month': '1.month',
                            'once a 3 month': '3.month',
                            'once a 4 month': '4.month',
                            'once a 6 month': '6.month',
                            'once a year': '12.month' }

  enum repayment_period: { '2 week': '0.5.month',
                           '1 month': '1.month',
                           '3 month': '3.month',
                           '6 month': '6.month',
                           '1 year': '12.month',
                           'year and a half': '18.month',
                           '2 years': '24.month',
                           '3 years': '32.month',
                           '5 years': '60.month',
                           '7 years': '84.month',
                           '10 years': '120.month',
                           '15 years': '180.month',
                           '20 years': '240.month' }

  validates :amount, presence: true, numericality: { greater_than: 0.0 }
  validates :currency, presence: true
  validates :goal, presence: true
  validates :interest_rate, presence: true
  validates :repayment_period, presence: true
  validates :payment_frequency, presence: true
  validates_with PeriodValidator

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

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :amount
      indexes :currency, analyzer: 'simple', search_analyzer: 'simple'
    end
  end

  def repayment_period_value
    period = Claim.repayment_periods[repayment_period]
    return 2.week if period == '0.5.month'

    modify_period(period)
  end

  def payment_frequency_value
    period = Claim.payment_frequencies[payment_frequency]
    return 2.week if period == '0.5.month'

    modify_period(period)
  end

  private

  def update_users_projects_statistics
    ActiveRecord::Base.transaction do
      user.profile.update(success_credit_project: user.profile.success_credit_project + 1)
      loan_participants.find_each do |participant|
        participant.user.profile.update(success_lend_project: participant.user.profile.success_lend_project + 1)
      end
    end
  end

  def modify_period(period)
    values = period.split('.')
    values.first.to_i.send(values.last)
  end
end
