require 'rails_helper'

describe RatingPolicy do
  subject { described_class.new(current_user, rating) }

  context 'being a user' do
    let(:current_user) { create(:user, role: 'user') }

    context 'when rating belongs to user' do
      let(:rating) { build(:rating, user: current_user) }

      it { is_expected.to permit_actions(%i[new create]) }
    end

    context 'when rating doesn\'t belong to user' do
      let(:another_user) { create(:user, role: 'user') }
      let(:rating) { build(:rating, user: another_user) }

      it { is_expected.to forbid_actions(%i[new create]) }
    end
  end

  context 'being an admin' do
    let(:current_user) { create(:user, role: 'admin') }

    context 'when rating belongs to user' do
      let(:rating) { build(:rating, user: current_user) }

      it { is_expected.to permit_actions(%i[new create]) }
    end

    context 'when rating doesn\'t belong to user' do
      let(:another_user) { create(:user, role: 'user') }
      let(:rating) { build(:rating, user: another_user) }

      it { is_expected.to forbid_actions(%i[new create]) }
    end
  end

  context 'being a visitor' do
    let(:current_user) { nil }
    let(:rating) { build(:rating, user: current_user) }

    it { is_expected.to forbid_actions(%i[new create]) }
  end
end
