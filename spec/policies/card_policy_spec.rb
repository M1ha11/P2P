require 'rails_helper'

describe CardPolicy do
  subject { described_class.new(current_user, card) }
  let(:resolved_scope) { described_class::Scope.new(current_user, Card.all).resolve }

  context 'being a user' do
    let(:current_user) { create(:user, role: 'user') }

    context 'when card belongs to user' do
      let(:card) { create(:card, user_id: current_user.id) }

      it { is_expected.to permit_actions(%i[index new create destroy]) }

      it 'includes card in scope' do
        expect(resolved_scope).to include(card)
      end
    end

    context 'when card doesn\'t belongs to user' do
      let(:another_user) { create(:user) }
      let(:card) { create(:card, user: another_user) }

      it { is_expected.to forbid_actions(%i[destroy]) }

      it 'doesn\'t include card in scope' do
        expect(resolved_scope).not_to include(card)
      end
    end
  end

  context 'being an admin' do
    let(:current_user) { create(:user, role: 'admin') }

    context 'when card belongs to user' do
      let(:card) { create(:card, user_id: current_user.id) }

      it { is_expected.to permit_actions(%i[index new create destroy]) }

      it 'includes card in scope' do
        expect(resolved_scope).to include(card)
      end
    end

    context 'when card doesn\'t belongs to user' do
      let(:another_user) { create(:user) }
      let(:card) { create(:card, user: another_user) }

      it { is_expected.to forbid_actions(%i[destroy]) }

      it 'doesn\'t include card in scope' do
        expect(resolved_scope).not_to include(card)
      end
    end
  end

  context 'being a visitor' do
    let(:current_user) { nil }
    let(:card) { create(:card) }

    it { is_expected.to forbid_actions(%i[index new create destroy]) }
  end
end
