require 'rails_helper'

RSpec.describe LoanParticipantsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:claim) { create(:claim) }

  describe 'POST create' do
    context 'when user authorize' do
      before do
        sign_in user
      end

      context 'with valid params' do
        let(:valid_loan_participant_params) { attributes_for(:loan_participant, claim_id: claim.id, user: user) }

        it 'creates new loan participant' do
          expect { post :create, params: { loan_participant: valid_loan_participant_params } }
            .to change { LoanParticipant.count }.by(1)
        end
      end

      context 'with invalid params' do
        let(:invalid_loan_participant_params) { attributes_for(:loan_participant, money: '',
                                                claim_id: claim.id, user: user) }

        it 'doesn\'t create new loan participant' do
          expect { post :create, params: { loan_participant: invalid_loan_participant_params } }
            .not_to change { LoanParticipant.count }
        end
      end
    end

    context 'when user unauthorize' do
      let(:loan_participant_params) { attributes_for(:loan_participant, claim_id: claim.id) }

      it 'returns moved status' do
        post :create, params: { loan_participant: loan_participant_params }
        expect(response).to have_http_status(302)
          .and redirect_to('/users/sign_in')
      end
    end
  end

  describe 'DELETE destroy' do
    let!(:loan_participant) { create(:loan_participant, user: user, claim_id: claim.id) }
    let(:loan_participant_id) { { id: loan_participant.id } }

    context 'when user authorize' do
      before do
        sign_in user
      end

      it 'destroys loan participant' do
        expect { delete :destroy, params: loan_participant_id }.to change { LoanParticipant.count }.by(-1)
        expect(response).to redirect_to('/claims')
      end
    end

    context 'when user unauthorize' do
      it 'doesn\'t destroy loan participant' do
        expect { delete :destroy, params: loan_participant_id }.not_to change { LoanParticipant.count }
      end
    end
  end
end
