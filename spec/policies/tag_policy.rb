require 'rails_helper'

describe TagPolicy do
  subject { described_class.new(current_user, tag) }

  context 'being a user' do
    let(:current_user) { create(:user, role: 'user') }
    let(:tag) { build(:tag) }

    it { is_expected.to forbid_actions(%i[create]) }
  end

  context 'being an admin' do
    let(:current_user) { create(:user, role: 'admin') }
    let(:tag) { build(:tag) }

    it { is_expected.to permit_actions(%i[create]) }
  end

  context 'being a visitor' do
    let(:current_user) { nil }
    let(:tag) { build(:tag) }

    it { is_expected.to forbid_actions(%i[create]) }
  end
end
