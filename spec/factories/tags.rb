# == Schema Information
#
# Table name: tags
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  name          :string(50)       not null
#  taggable_type :string           not null
#  taggable_id   :bigint           not null
#
FactoryBot.define do
  factory :tag do
    
  end
end
