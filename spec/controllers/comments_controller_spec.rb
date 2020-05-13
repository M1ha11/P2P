require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:current_user) { create(:user, role: 'user') }
  let(:commentable) { create(:claim, user: current_user) }

  describe 'GET new' do
    before do
      sign_in current_user
    end

    # it 'returns success status' do
    #   get :new, params: { commentable_id: commentable.id, commentable_type: commentable.class.to_s }
    #   expect(response).to have_http_status(200)
    # end
  end

  describe 'POST create' do   
    before do
      sign_in current_user
    end

    context 'with valid params' do
      let(:comment) { build(:comment, user_id: current_user.id,
                      commentable_id: commentable.id, commentable_type: commentable.class.to_s) }
      let(:comment_params) { { comment: comment.attributes } }

      it 'create new comment' do
        expect{ post :create, params: { comment: comment_params, claim_id: commentable.id } }.to change{ Comment.count }.by(1)
      end
    end

    context 'with invalid params' do
      let(:comment) { FactoryBot.attributes_for(:comment)[''] }

      it 'doesn\'t create comment' do
        expect{ post :create, params: { comment: comment, user_id: current_user.id,
                commentable_id: commentable.id, commentable_type: commentable.class.to_s } }.to_not change{ Comment.count }
      end
    end
  end

  describe 'DELETE destroy' do
    context 'when delete yourself comment' do
      let(:comment) { create(:comment, user_id: current_user.id,
                      commentable: commentable) }

      it 'deletes comment' do
        expect{ delete :destroy, params: { id: comment.id, claim_id: commentable.id } }.to change{ Comment.count }.by(-1)
      end
    end

    context 'when delete other persons comment' do
    end
  end
end