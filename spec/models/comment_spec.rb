# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  text             :string           not null
#  parent_id        :integer
#  user_id          :bigint           not null
#  commentable_type :string
#  commentable_id   :bigint
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  subject { build(:comment, user: user) }

  context 'with valid attributtes' do
    it 'is valid' do
      expect(subject).to be_valid
    end
  end

  include_examples 'invalid without attributes', :text
end
