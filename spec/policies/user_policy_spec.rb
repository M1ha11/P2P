require 'rails_helper'

describe UserPolicy do
  subject { described_class.new(current_user, user) }
  let(:resolved_scope) { described_class::Scope.new(current_user, User.all).resolve }

  context 'being a user' do
    let(:current_user) { create(:user, role: 'user') }
    let(:user) { create(:user) }

    it { is_expected.to forbid_actions(%i[index lock unlock change_role]) }
  end

  context 'being an admin' do
    let(:current_user) { create(:user, role: 'admin') }

    context 'when user is admin' do
      let(:user) { create(:user, role: 'admin') }

      it 'includes user to scope' do
        expect(resolved_scope).to include(user)
      end

      it 'doesn\'t include yourself' do
        expect(resolved_scope).not_to include(current_user)
      end

      it { is_expected.to forbid_actions(%i[lock unlock]) }
      it { is_expected.to permit_actions(%i[index change_role]) }
    end

    context 'when user has role user' do
      let(:user) { create(:user, role: 'user') }

      it 'includes user to scope' do
        expect(resolved_scope).to include(user)
      end

      it 'doesn\'t include yourself' do
        expect(resolved_scope).not_to include(current_user)
      end

      context 'when user locked' do
        let(:user) { create(:user, role: 'user', locked_at: Date.today) }

        it { is_expected.to permit_actions(%i[index unlock]) }
      end

      context 'when user not locked' do
        it { is_expected.to permit_actions(%i[index lock change_role]) }
      end
    end
  end

  context 'being a visitor' do
    let(:current_user) { nil }
    let(:user) { create(:user) }

    it { is_expected.to forbid_actions(%i[index lock unlock change_role]) }
  end
end
