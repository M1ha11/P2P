# == Schema Information
#
# Table name: claims
#
#  id                :bigint           not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  amount            :float
#  currency          :integer
#  goal              :string
#  interest_rate     :float
#  repaiment_period  :integer
#  payment_frequency :integer
#  status            :integer
#
require 'rails_helper'

RSpec.describe Claim, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
