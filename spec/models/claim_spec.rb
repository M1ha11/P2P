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
  subject { build(:claim) }

  context 'with valid attributes' do
    it 'is valid' do
      expect(subject).to be_valid
    end
  end

  include_examples 'invalid without attributes', :amount, :goal

  include_examples 'invalid with incorrect attributes', { field: :amount, params: 'one' }
end
