require 'rails_helper'

describe ProfilePolicy do
  subject { described_class.new(current_user, profile) }

  context 'being a user' do
    let(:current_user) { create(:user, role: 'user') }

    context 'when profile belongs to user' do
      let(:profile) { build(:profile, user: current_user) }

      it { is_expected.to permit_actions(%i[show update edit]) }
    end

    context 'when profile doesn\'t belongs to user' do
      let(:anohter_user) { create(:user) }
      let(:profile) { build(:profile, user: anohter_user) }

      it { is_expected.to forbid_actions(%i[show update edit]) }
    end
  end

  context 'being an admin' do
    let(:current_user) { create(:user, role: 'admin') }

    context 'when profile belongs to user' do
      let(:profile) { build(:profile, user: current_user) }

      it { is_expected.to permit_actions(%i[show update edit]) }
    end

    context 'when profile doesn\'t belongs to user' do
      let(:anohter_user) { create(:user) }
      let(:profile) { build(:profile, user: anohter_user) }

      it { is_expected.to forbid_actions(%i[update edit]) }
      it { is_expected.to permit_actions(%i[show]) }
    end
  end

  context 'being a visitor' do
    let(:current_user) { nil }
    let(:profile) { build(:profile, user: current_user) }

    it { is_expected.to forbid_actions(%i[new create destroy]) }
  end
end