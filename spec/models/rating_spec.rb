# == Schema Information
#
# Table name: ratings
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  rate        :integer
#  user_id     :bigint           not null
#  reviewed_id :integer          not null
#
require 'rails_helper'

RSpec.describe Rating, type: :model do
  let(:user) { create(:user) }
  subject { build(:rating, user: user) }

  context 'with valid attributtes' do
    it 'is valid' do
      expect(subject).to be_valid
    end
  end

  include_examples 'invalid without attributes', :rate

  include_examples 'invalid with incorrect attributes', { field: :rate, params: 10 }
end
