# == Schema Information
#
# Table name: loan_participants
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#  claim_id   :bigint
#  money      :float
#
require 'rails_helper'

RSpec.describe LoanParticipant, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
