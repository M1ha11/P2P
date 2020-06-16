require 'rails_helper'

RSpec.describe ClaimsController, type: :controller do
  describe 'GET index' do
    context 'when user role is user' do
      let(:current_user) { create(:user, role: 'user') }
      let!(:claims) { create_list(:claim, 3, status: 'publicly') }

      before do
        sign_in current_user
      end

      it 'returns status 200' do
        get :index
        expect(response).to have_http_status(200)
      end

      it 'return claims' do
        get :index
        expect(assigns(:claims)).to eq(claims)
        expect(assigns(:claims).pluck(:amount)).to eq(claims.pluck(:amount))
      end
    end
  end

  describe 'GET new' do
    let(:claim) { create(:claim, user_id: current_user.id) }
    let(:current_user) { create(:user, role: 'user') }

    before do
      sign_in current_user
    end

    it 'returns assings to new claim' do
      get :new
      expect(assigns(:claim)).to be_a_new(Claim)
    end
  end

  describe 'POST create' do
    context 'when user authorize' do
      let(:current_user) { create(:user) }

      before do
        sign_in current_user
      end

      context 'with valid params' do
        let(:valid_claim_params) { attributes_for(:claim, user_id: current_user.id) }

        it 'creates new claim' do
          expect { post :create, params: { claim: valid_claim_params } }.to change { Claim.count }.by(1)
        end
      end

      context 'with invalid params' do
        let(:invalid_claim_params) { attributes_for(:claim, amount: 'not work', user_id: current_user.id) }

        it 'doesn\'t create new claim' do
          expect { post :create, params: { claim: invalid_claim_params } }.to_not change { Claim.count }
        end
      end
    end

    context 'when user unauthorize' do
      it 'returns moved status' do
        post :create
        expect(response).to have_http_status(302)
          .and redirect_to('/users/sign_in')
      end
    end
  end

  describe 'GET show' do
    let(:current_user) { create(:user) }
    let!(:claim) { create(:claim, user_id: current_user.id) }

    it 'returns claim' do
      get :show, params: { id: claim.id }

      expect(assigns(:claim)).to eq(claim)
      expect(assigns(:claim).currency).to eq(claim[:currency])
    end
  end

  describe 'DELETE destroy' do
    context 'when user authorize' do
      let(:current_user) { create(:user) }
      let!(:claim) { create(:claim, user_id: current_user.id) }
      let(:claim_id) { { id: claim.id } }

      before do
        sign_in current_user
      end

      it 'destroys claim' do
        expect { delete :destroy, params: claim_id }.to change { Claim.count }.by(-1)
        expect(response).to redirect_to('/claims')
      end
    end

    context 'when user unauthorize' do
      let!(:claim) { create(:claim) }
      let(:claim_id) { { id: claim.id } }

      it 'returns doesn\'t destroy claim' do
        expect { delete :destroy, params: claim_id }.to_not change { Claim.count }
        expect(response).to redirect_to('/users/sign_in')
      end
    end
  end
end
