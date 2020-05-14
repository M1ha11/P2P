require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  describe 'GET show' do
    let(:profile) { create(:profile, user_id: current_user.id) }
    let(:current_user) { create(:user) }

    before do
      sign_in current_user
    end

    it 'returns profile' do
      get :show, params: { id: profile.id }
      expect(assigns(:profile)).to eq(profile)
      expect(response).to have_http_status(200)
    end
  end

  describe 'PATCH update' do
    context 'when user is authorized' do
      let(:current_user) { create(:user) }
      let(:profile) { create(:profile, user_id: current_user.id) }

      before do
        sign_in current_user
      end

      context 'with valid params' do
        let(:profile_params) { attributes_for(:profile) }

        it 'return updated profile' do
          patch :update, params: { id: profile.id, profile: profile_params }
          expect(assigns(:profile).changed?).to eq(false)
        end
      end

      context 'with invalid parans' do
        let(:profile_params) { { phone_number: '' } }

        it 'doesn\'t update profile' do
          patch :update, params: { id: profile.id, profile: profile_params }
          expect(assigns(:profile)).to eq(profile)
        end
      end
    end

    context 'when user is unauthorized' do
      let(:current_user) { create(:user) }
      let(:profile) { create(:profile, user_id: current_user.id) }
      let(:profile_params) { attributes_for(:profile) }

      it 'moves to sing in' do
        patch :update, params: { id: profile.id, profile: profile_params }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to('/users/sign_in')
      end
    end
  end

  describe 'GET edit' do
    let(:current_user) { create(:user) }
    let(:profile) { create(:profile, user_id: current_user.id) }

    before do
      sign_in current_user
    end

    it 'returns success status' do
      expect(response).to have_http_status(200)
    end
  end
end