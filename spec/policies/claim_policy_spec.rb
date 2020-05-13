require 'rails_helper'

describe ClaimPolicy do
  subject{ described_class.new(current_user, claim) }
  let(:resolved_scope) { described_class::Scope.new(current_user, Claim.all).resolve }

  context 'being a user' do
    let(:current_user) { create(:user, role: 'user') }

    context 'when claim belongs to user' do
      let(:claim) { create(:claim, user: current_user) }

      context 'when claim publicly' do
        let(:claim) { create(:claim, user: current_user, status: 'publicly') }

        it 'includes claim in scope' do
          expect(resolved_scope).to include(claim)
        end
      end

      context 'when claim privatly' do
        let(:claim) { create(:claim, user: current_user, status: 'privatly') }

        it 'includes claim in scope' do
          expect(resolved_scope).to include(claim)
        end
      end

      it { is_expected.to permit_actions(%i[index show new create destroy edit update]) }
    end

    context 'when claim doesn\'t belongs to user' do
      let(:another_user) { create(:user) }
      let(:claim) { create(:claim, user: another_user) }

      context 'when claim publicly' do
        let(:claim) { create(:claim, user: another_user, status: 'publicly') }

        it 'includes claim in scope' do
          expect(resolved_scope).to include(claim)
        end
      end

      context 'when claim privatly' do
        let(:claim) { create(:claim, user: another_user, status: 'privatly') }

        it 'includes claim in scope' do
          expect(resolved_scope).not_to include(claim)
        end
      end

      it { is_expected.to permit_actions(%i[index show]) }
      it { is_expected.to forbid_actions(%i[create destroy edit update]) }
    end
  end

  context 'being an admin' do
    let(:current_user) { create(:user, role: 'admin') }

    context 'when claim belongs to admin' do
      let(:claim) { create(:claim, user: current_user) }

      context 'when claim publicly' do
        let(:claim) { create(:claim, user: current_user, status: 'publicly') }

        it 'includes claim in scope' do
          expect(resolved_scope).to include(claim)
        end
      end

      context 'when claim privatly' do
        let(:claim) { create(:claim, user: current_user, status: 'privatly') }

        it 'includes claim in scope' do
          expect(resolved_scope).to include(claim)
        end
      end

      it { is_expected.to permit_actions(%i[index show new create destroy edit update]) }
    end

    context 'when claim doesn\'t belongs to admin' do
      let(:another_user) { create(:user) }
      let(:claim) { create(:claim, user: another_user) }

      context 'when claim publicly' do
        let(:claim) { create(:claim, user: another_user, status: 'publicly') }

        it 'includes claim in scope' do
          expect(resolved_scope).to include(claim)
        end
      end

      context 'when claim privatly' do
        let(:claim) { create(:claim, user: another_user, status: 'privatly') }

        it 'includes claim in scope' do
          expect(resolved_scope).to include(claim)
        end
      end

      it { is_expected.to permit_actions(%i[index show new destroy]) }
    end
  end

  context 'being a visitor' do
    let(:current_user) { nil }
    let(:claim) { create(:claim) }
    let(:another_user) { create(:user) }

    context 'when claim publicly' do
        let(:claim) { create(:claim, user: another_user, status: 'publicly') }

        it 'includes claim in scope' do
          expect(resolved_scope).to include(claim)
        end
      end

      context 'when claim privatly' do
        let(:claim) { create(:claim, user: another_user, status: 'privatly') }

        it 'includes claim in scope' do
          expect(resolved_scope).not_to include(claim)
        end
      end

    it { is_expected.to permit_actions(%i[index show]) }
    it { is_expected.to forbid_actions(%i[destroy new create edit update]) }
  end
end