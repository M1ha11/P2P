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
#
class Claim < ApplicationRecord
  belongs_to :user
  has_many :loan_participants, dependent: :destroy
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings
  has_many :comments, as: :commentable, dependent: :destroy

  enum status: { publicly: 'publicly', privatly: 'privatly', archive: 'archive',
                 confirmed: 'confirmed' }
                 
  enum payment_frequency: { "#{I18n.t('activerecord.attributes.claim.payment_frequencies.twice_a_month')}": '0.5.month',
                            "#{I18n.t('activerecord.attributes.claim.payment_frequencies.once_a_month')}": '1.month',
                            "#{I18n.t('activerecord.attributes.claim.payment_frequencies.once_a_3_month')}": '3.month',
                            "#{I18n.t('activerecord.attributes.claim.payment_frequencies.once_a_4_month')}": '4.month',
                            "#{I18n.t('activerecord.attributes.claim.payment_frequencies.once_a_6_month')}": '6.month',
                            "#{I18n.t('activerecord.attributes.claim.payment_frequencies.once_a_year')}": '12.month' }

  enum repayment_period: { "#{I18n.t('activerecord.attributes.claim.repayment_periods.2_week')}": '0.5.month',
                           "#{I18n.t('activerecord.attributes.claim.repayment_periods.1_month')}": '1.month',
                           "#{I18n.t('activerecord.attributes.claim.repayment_periods.3_month')}": '3.month',
                           "#{I18n.t('activerecord.attributes.claim.repayment_periods.6_month')}": '6.month',
                           "#{I18n.t('activerecord.attributes.claim.repayment_periods.1_year')}": '12.month',
                           "#{I18n.t('activerecord.attributes.claim.repayment_periods.year_and_a_half')}": '18.month',
                           "#{I18n.t('activerecord.attributes.claim.repayment_periods.2_years')}": '24.month',
                           "#{I18n.t('activerecord.attributes.claim.repayment_periods.3_years')}": '32.month',
                           "#{I18n.t('activerecord.attributes.claim.repayment_periods.5_years')}": '60.month',
                           "#{I18n.t('activerecord.attributes.claim.repayment_periods.7_years')}": '84.month',
                           "#{I18n.t('activerecord.attributes.claim.repayment_periods.10_years')}": '120.month',
                           "#{I18n.t('activerecord.attributes.claim.repayment_periods.15_years')}": '180.month',
                           "#{I18n.t('activerecord.attributes.claim.repayment_periods.20_years')}": '240.month' }

  validates :amount, presence: true, numericality: true
  validates :currency, presence: true
  validates :goal, presence: true
  validates :interest_rate, presence: true
  validates :repayment_period, presence: true
  validates :payment_frequency, presence: true

  def repayment_period_value
    Claim.repayment_periods[repayment_period]
  end
end
