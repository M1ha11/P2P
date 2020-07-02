require 'rails_helper'

RSpec.describe TaggingsController, type: :controller do
  describe 'DELETE destroy' do
    let(:current_user) { create(:user, role: 'admin') }
    let(:claim) { create(:claim, user: current_user) }
    let(:tag) { create(:tag) }
    let!(:tagging) { create(:tagging, tag: tag, taggable_id: claim.id, taggable_type: claim.class.name) }

    before do
      sign_in current_user
    end

    it 'destroys tagging' do
      expect { delete :destroy, params: { id: tagging.id, claim_id: claim.id } }.to change { Tagging.count }.by(-1)
    end
  end
end
