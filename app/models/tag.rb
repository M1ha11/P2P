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
class Tag < ApplicationRecord
  belongs_to :taggable, polymorphic: true

  validates :name, presence: true, format: { with: /\A(#\w+)\z/ }

  scope :for_entity, ->(taggable_type) { where(taggable_type: taggable_type) }
end
