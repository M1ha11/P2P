require 'rails_helper'

RSpec.describe CardsController, type: :controller do
  let(:current_user) { create(:user) }

  describe 'GET index' do
    let(:card) { create(:card, user_id: current_user.id) }

    context 'when user authorized' do
      before do
        sign_in current_user
      end

      it 'returns user credit cards' do
        get :index

        expect(response).to have_http_status(200)
        expect(assigns(:cards)).to eq([card])
      end
    end

    context 'when user unauthorized' do
      it 'returns moved status' do
        get :index
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'GET new' do
    context 'when user authorized' do
      let(:card) { build(:card, user_id: current_user.id) }

      before do
        sign_in current_user
      end

      it 'returns ok status' do
        get :new
        expect(response).to have_http_status(200)
      end

      it 'get assign to new card' do
        get :new
        expect(assigns(:card)).to be_a_new(Card)
      end
    end

    context 'when user unauthorized' do
      it 'returns moved status' do
        get :new
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'POST create' do
    context 'when user authorized' do
      before do
        sign_in current_user
      end

      context 'when params is valid' do
        let(:card) { build(:card, user_id: current_user.id) }
        let(:card_params) { { card: card.attributes } }

        it 'creates new credit card' do
          expect{ post :create, params: card_params }.to change{ Card.count }.by(1)
        end
      end

      context 'when params is invalid' do
        let(:invalid_card) { build(:card, expire_date: '33/2000', user_id: current_user.id) }
        let(:invalid_card_params) { { card: invalid_card.attributes } }

        it 'doesn\'t create credit card' do
          expect{ post :create, params: invalid_card_params }.to_not change{ Card.count }
        end
      end
    end

    context 'when user unauthorized' do
      it 'returns moved status' do
        post :create
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'DELETE destroy' do
    let!(:user_card) { create(:card, user_id: current_user.id) }
    let(:user_card_id) { { id: user_card.id } }

    context 'when user authorized' do
      before do
        sign_in current_user
      end

      it 'deletes credit card' do
        expect{ delete :destroy, params: user_card_id }.to change{ Card.count }.by(-1)
        expect(response).to have_http_status(302)
      end
    end

    context 'when user unauthorized' do
      it 'returns moved status' do
        expect{ delete :destroy, params: user_card_id }.to_not change{ Card.count }
      end
    end
  end
end