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
require 'rails_helper'

RSpec.describe Claim, type: :model do
  let(:user) { create(:user) }
  subject { build(:claim, user: user) }

  context 'with valid attributes' do
    it 'is valid' do
      expect(subject).to be_valid
    end
  end

  include_examples 'invalid without attributes', :amount, :goal

  include_examples 'invalid with incorrect attributes', { field: :amount, params: 'one' }

  context 'elasticsearch' do
    let!(:claim) { create(:claim, user: user) }

    it 'returns requested results' do
      Claim.__elasticsearch__.refresh_index!
      expect(Claim.search(claim.currency).records.length).to eq(1)
    end
  end
end
