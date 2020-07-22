require 'rails_helper'

RSpec.describe RatingsController, type: :controller do
  let(:current_user) { create(:user, :user_with_claims) }
  let(:rating) { build(:rating, user: current_user, ratable: current_user.claims.last) }

  describe 'GET new' do
    before do
      sign_in current_user
    end

    it 'returns assigns to new Rating' do
      get :new

      expect(assigns(:rating)).to be_a_new(Rating)
    end
  end

  describe 'POST create' do
    context 'when user authorize' do
      before do
        sign_in current_user
      end

      context 'with valid params' do
        let(:valid_params) { attributes_for(:rating, user_id: current_user.id, reviewed_id: User.first.id,
                             ratable_type: current_user.claims.last.class.to_s, ratable_id: current_user.claims.last.id) }

        it 'creates new Rating' do
          expect { post :create, params: { rating: valid_params } }.to change { Rating.count }.by(1)
        end
      end

      context 'with invalid params' do
        let(:invalid_params) { attributes_for(:rating, rate: 10, user_id: current_user.id) }

        it 'doesn\'t create new Rating' do
          expect { post :create, params: { rating: invalid_params } }.to_not change { Rating.count }
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
end
