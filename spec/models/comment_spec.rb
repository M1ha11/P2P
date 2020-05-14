# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  text             :string
#  parent_id        :integer
#  user_id          :bigint           not null
#  commentable_type :string
#  commentable_id   :bigint
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { build(:comment) }
  let(:invalid_text) { build(:comment, text: '') }

  it 'is valid with all valid params' do
    expect(subject).to be_valid
  end

  it 'is invalid without attribute' do
    subject[:text] = nil
    subject[:user_id] = nil

    expect(subject).not_to be_valid
  end

  it 'is invalid with wrong attributes' do
    expect(invalid_text).not_to be_valid
  end
end
