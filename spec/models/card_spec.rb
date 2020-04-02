# == Schema Information
#
# Table name: cards
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  card_number :string(19)       not null
#  expire_date :string           not null
#  user_id     :bigint           not null
#
require 'rails_helper'

RSpec.describe Card, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
