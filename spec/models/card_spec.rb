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
  subject { build(:card) }
  let(:invalid_card_number) { build(:card, card_number: '1111111111111111111') }
  let(:invalid_expire_date) { build(:card, expire_date: '30/2020') }

  it 'is valid with all valid params' do
    expect(subject).to be_valid
  end

  it 'is invalid without attribute' do
    subject[:card_number] = nil
    subject[:expire_date] = nil

    expect(subject).not_to be_valid
  end

  it 'is invalid with wrong attributes' do
    expect(invalid_card_number).not_to be_valid
    expect(invalid_expire_date).not_to be_valid
  end
end
