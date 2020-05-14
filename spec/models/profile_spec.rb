# == Schema Information
#
# Table name: profiles
#
#  id                     :bigint           not null, primary key
#  success_credit_project :integer          default("0")
#  success_lend_project   :integer          default("0")
#  phone_number           :string(25)       not null
#  address                :string(150)      not null
#  avatar                 :string
#  user_id                :bigint           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
require 'rails_helper'

RSpec.describe Profile, type: :model do
  subject { build(:profile) }
  let(:invalid_phone_number) { build(:profile, phone_number: '+375') }
  let(:invalid_address) { build(:profile, address: Faker::Lorem.sentence(word_count: 100)) }

  it 'is valid with all valid params' do
    expect(subject).to be_valid
  end

  it 'is valid without avatar' do
    subject[:avatar] = nil

    expect(subject).to be_valid
  end

  it 'is invalid without attribute' do
    subject[:phone_number] = nil
    subject[:address] = nil

    expect(subject).not_to be_valid
  end

  it 'is invalid with wrong attributes' do
    expect(invalid_phone_number).not_to be_valid
    binding.pry
    expect(invalid_address).not_to be_valid
  end
end
