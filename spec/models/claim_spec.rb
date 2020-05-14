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
require 'rails_helper'

RSpec.describe Claim, type: :model do
  let(:user) { create(:user) }
  subject { build(:claim, user: user) }
  let(:invalid_amount) { build(:claim, amount: 'one') }
  # let(:invalid_currency) { build(:claim, currency: 'one') }
  # let(:invalid_interest_rate) { build(:claim, interest_rate: 'one') }
  # let(:invalid_repayment_period) { build(:claim, repayment_period: 'one') }
  # let(:invalid_status) { build(:claim, status: 'one') }
  # let(:invalid_payment_frequency) { build(:claim, payment_frequency: 'one') }


  it 'is valid with all correct attributes' do
    expect(subject).to be_valid
  end

  it 'is invalid without attributes' do
    subject[:amount] = nil
    subject[:currency] = nil
    subject[:goal] = nil
    subject[:interest_rate] = nil
    subject[:repayment_period] = nil
    subject[:status] = nil
    subject[:payment_frequency] = nil

    expect(subject).not_to be_valid
  end

  it 'is invalid with wrong attributes' do
    expect(invalid_amount).not_to be_valid
    # expect(invalid_currency).not_to be_valid
    # expect(invalid_interest_rate).not_to be_valid
    # expect(invalid_repayment_period).not_to be_valid
    # expect(invalid_status).not_to be_valid
  end
end
