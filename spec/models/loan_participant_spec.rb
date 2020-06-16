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
require 'rails_helper'

RSpec.describe LoanParticipant, type: :model do
  subject { build(:loan_participant) }

  context 'with valid attributtes' do
    it 'is valid' do
      expect(subject).to be_valid
    end
  end

  include_examples 'invalid without attributes', :money
end
