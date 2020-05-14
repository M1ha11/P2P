require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:current_user) { create(:user, role: 'admin') }

  describe 'GET index' do
    let(:users) { create_list(:user, 3) }

    context 'when user authorize' do
      before do
        sign_in current_user
      end

      it 'returns users' do
        get :index
        expect(assigns(:users)).to eq(users)
      end

      it 'returns succes status' do
        get :index
        expect(response).to have_http_status(200)
      end
    end

    context 'when user unauthorize' do
      it 'returns moved status' do
        get :index
        expect(response).to have_http_status(302)
        expect(response).to redirect_to('/users/sign_in')
      end
    end
  end

  describe 'PATCH lock' do
    let(:user) { create(:user, role: 'user') }

    before do
        sign_in current_user
    end

    it 'locks user' do
      patch :lock, params: { id: user.id }
      expect(user.locked_at).not_to be_blank
    end
  end

  describe 'PATCH unlock' do
    let(:user) { create(:user, role: 'user', locked_at: Date.today) }

    before do
      sign_in current_user
    end

    it 'locks user' do
      patch :unlock, params: { id: user.id }
      expect(user.locked_at).to be_blank
    end
  end

  describe 'PATCH change_role' do
    let(:user) { create(:user, role: 'user') }
    let(:user_params) { { role: 'admin' } }

    before do
      sign_in current_user
    end

    it 'update user role' do
      patch :change_role, params: { id: user.id, user: user_params }
      expect(assigns(:user).changed?).to eq(false)
    end
  end
end