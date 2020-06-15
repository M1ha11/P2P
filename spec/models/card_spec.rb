# == Schema Information
#
# Table name: cards
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  card_number :string(19)       not null
#  expire_date :string           not null
#  user_id     :bigint           not null
#
require 'rails_helper'

RSpec.describe Card, type: :model do
  let(:user) { create(:user) }
  subject { build(:card, user_id: user.id) }

  context 'with valid attributes' do
    it 'is valid with all valid params' do
      expect(subject).to be_valid
    end
  end

  include_examples 'invalid without attributes', :card_number, :expire_date

  include_examples 'invalid with incorrect attributes', { field: :card_number,
                                                          params: Faker::Number.leading_zero_number(digits: 17) },
                                                        { field: :expire_date,
                                                          params: '30/2020' }
end
