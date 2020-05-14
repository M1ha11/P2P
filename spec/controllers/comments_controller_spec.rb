require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:current_user) { create(:user, role: 'user') }
  let(:commentable) { create(:claim, user: current_user) }

  # describe 'GET new' do
  #   before do
  #     sign_in current_user
  #   end

  #   it 'returns success status' do
  #     get :new, params: { claim_id: commentable.id }
  #     expect(response.content_type).to eq("text/html")
  #   end
  # end

  describe 'POST create' do   
    before do
      sign_in current_user
    end

    context 'with valid params' do
      let(:comment_params) { attributes_for(:comment, commentable: commentable)
                             .merge(commentable_id: commentable.id, commentable_type: commentable.class.name) }

      it 'create new comment' do
        expect{ post :create, params: { comment: comment_params, claim_id: commentable.id } }
                                        .to change{ Comment.count }.by(1)
      end
    end

    context 'with invalid params' do
      let(:comment_params) { attributes_for(:comment, text: '', commentable: commentable)
                      .merge(commentable_id: commentable.id, commentable_type: commentable.class.name) }

      it 'doesn\'t create comment' do
        expect{ post :create, params: { comment: comment_params, claim_id: commentable.id } }
                .to_not change{ Comment.count }
      end
    end
  end

  describe 'DELETE destroy' do
    context 'when delete yourself comment' do
      let!(:comment) { create(:comment, commentable: commentable, user_id: current_user.id) }

      before do
        sign_in current_user
      end

      it 'deletes comment' do
        expect{ delete :destroy, params: { id: comment.id, claim_id: commentable.id } }
                                           .to change{ Comment.count }.by(-1)
      end
    end

    context 'when delete other persons comment' do
      let(:user) { create(:user) }
      let!(:comment) { create(:comment, commentable: commentable, user_id: user.id) }

      before do
        sign_in current_user
      end

      it 'doesn\'t delete comment' do
        expect{ delete :destroy, params: { id: comment.id, claim_id: commentable.id } }
                                           .not_to change{ Comment.count }
      end
    end
  end
end