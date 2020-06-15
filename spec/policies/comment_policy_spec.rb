require 'rails_helper'

describe CommentPolicy do
  subject { described_class.new(current_user, comment) }

  context 'being a user' do
    let(:current_user) { create(:user, role: 'user') }

    context 'when comment belongs to user' do
      let(:comment) { build(:comment, user: current_user) }

      it { is_expected.to permit_actions(%i[new create destroy]) }
    end

    context 'when comment doesn\'t belong to user' do
      let(:another_user) { create(:user, role: 'user') }
      let(:comment) { build(:comment, user: another_user) }
      
      it { is_expected.to permit_actions(%i[new create]) }
      it { is_expected.to forbid_actions(%i[destroy]) }
    end
  end

  context 'being an admin' do
    let(:current_user) { create(:user, role: 'admin') }
    let(:comment) { build(:comment, user: current_user) }

    it { is_expected.to permit_actions(%i[new create destroy]) }
  end

  context 'being a visitor' do
    let(:current_user) { nil }
    let(:comment) { build(:comment, user: current_user) }

    it { is_expected.to forbid_actions(%i[new create]) }
  end
end
