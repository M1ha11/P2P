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
#  locale                 :string(10)       default("en"), not null
#
require 'rails_helper'

RSpec.describe Profile, type: :model do
  subject { build(:profile) }

  context 'with valid attributes' do
    it 'is valid with all valid params' do
      expect(subject).to be_valid
    end
  end

  include_examples 'valid without attributes', :avatar

  include_examples 'invalid without attributes', :phone_number, :address

  include_examples 'invalid with incorrect attributes', { field: :phone_number,
                                                          params: '+375' },
                                                        { field: :phone_number,
                                                          params: Faker::PhoneNumber.subscriber_number(length: 26) },
                                                        { field: :address,
                                                          params: Faker::Lorem.sentence(word_count: 200) }
end
