require 'rails_helper'

describe UserPolicy do
  subject { described_class.new(current_user, user) }

  context 'being a user' do
    let(:current_user) { create(:user, role: 'user') }

    
  end

  context 'being an admin' do
    
  end

  context 'being a visitor' do
  end
end