require 'rails_helper'

RSpec.describe TagsController, type: :controller do
  describe 'POST create' do
    let(:current_user) { create(:user, role: 'admin') }
    let(:taggable) { create(:claim, user: current_user) }

    before do
      sign_in current_user
    end

    context 'with valid params' do
      let(:valid_params) { attributes_for(:tag, taggable: taggable) }

      it 'creates new tag' do
        expect { post :create, params: { tag: valid_params, claim_id: taggable.id } }.to change { Tag.count }.by(1)
      end
    end

    context 'with invalid params' do
      let(:invalid_tag_params) { attributes_for(:tag, name: 'example', taggable: taggable) }

      it 'doesn\'t create tag' do
        expect { post :create, params: { tag: invalid_tag_params, claim_id: taggable.id } }.not_to change { Tag.count }
      end
    end
  end
end
