require 'rails_helper'

describe LoanParticipantPolicy do
  subject { described_class.new(current_user, loan_participant) }

  context 'being a user' do
    let(:current_user) { create(:user, role: 'user') }
 
    context 'when current user is not claim owner' do
      let(:another_user) { create(:user) }
      let(:claim) { create(:claim, user: another_user) }
      let(:loan_participant) { build(:loan_participant, user: current_user, claim: claim) }

      it { is_expected.to permit_actions(%i[create destroy]) }
    end

    context 'when current user is claim owner' do
      let(:claim) { create(:claim, user: current_user) }
      let(:another_user) { create(:user) }
      let(:loan_participant) { build(:loan_participant, claim: claim, user: another_user) }

      context 'when current user want to be loan partipipant' do
        let(:loan_participant) { build(:loan_participant, claim: claim, user: current_user) }

        it { is_expected.to forbid_actions(%i[create]) }
      end

      it { is_expected.to permit_actions(%i[destroy]) }
    end

  end

  context 'being an admin' do
    let(:current_user) { create(:user, role: 'admin') }

    context 'when current user is not claim owner' do
      let(:another_user) { create(:user) }
      let(:claim) { create(:claim, user: another_user) }
      let(:loan_participant) { build(:loan_participant, user: current_user, claim: claim) }

      it { is_expected.to permit_actions(%i[create destroy]) }
    end

    context 'when current user is claim owner' do
      let(:claim) { create(:claim, user: current_user) }
      let(:another_user) { create(:user) }
      let(:loan_participant) { build(:loan_participant, claim: claim, user: another_user) }

      context 'when current user want to be loan partipipant' do
        let(:loan_participant) { build(:loan_participant, claim: claim, user: current_user) }

        it { is_expected.to forbid_actions(%i[create]) }
      end

      it { is_expected.to permit_actions(%i[destroy]) }
    end
  end

  context 'being a visitor' do
    let(:current_user) { nil }
    let(:loan_participant) { build(:loan_participant) }

    it { is_expected.to forbid_actions(%i[create destroy]) }
  end
end