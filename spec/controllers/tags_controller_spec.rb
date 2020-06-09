require 'rails_helper'

RSpec.describe TagsController, type: :controller do
  describe 'POST create' do
    let(:current_user) { create(:user, role: 'admin') }

    before do
      sign_in current_user
    end

    context 'with valid params' do
      
    end

    context 'with invalid params' do
      let(:invalid_tag_params) { attributes_for(:tag, name: 'example') }

      it 'doesn\'t create tag' do
        expect { post :create, params: invalid_tag_params }.not_to change{ Tag.count }
      end
    end
  end
end