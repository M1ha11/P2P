# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string(50)       not null
#
require 'rails_helper'

RSpec.describe Tag, type: :model do
  subject { build(:tag) }

  context 'with valid attributtes' do
    it 'is valid' do
      expect(subject).to be_valid
    end
  end

  include_examples 'invalid without attributes', :name

  include_examples 'invalid with incorrect attributes', { field: :name, params: 'one' }

  context 'elasticsearch' do
    let!(:tag) { create(:tag) }

    it 'returns requested results' do
      Tag.__elasticsearch__.refresh_index!
      expect(Tag.search(tag.name).records.length).to eq(1)
    end
  end
end
