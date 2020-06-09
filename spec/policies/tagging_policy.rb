require 'rails_helper'

describe TaggingPolicy do
  subject { described_class.new(current_user, tagging) }

  context 'being a user' do
    let(:current_user) { create(:user, role: 'user') }
    let(:tagging) { create(:tagging) }

    it { is_expected.to forbid_actions(%i[destroy]) }
  end

  context 'being an admin' do
    let(:current_user) { create(:user, role: 'admin') }
    let(:tagging) { create(:tagging) }

    it { is_expected.to permit_actions(%i[destroy]) }
  end

  context 'being a visitor' do
    let(:current_user) { nil }
    let(:tagging) { create(:tagging) }

    it { is_expected.to forbid_actions(%i[destroy]) }
  end
end