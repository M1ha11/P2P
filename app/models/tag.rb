# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string(50)       not null
#
class Tag < ApplicationRecord
  has_many :taggings
  has_many :taggable, through: :taggings

  validates :name, presence: true, format: { with: /\A(#\w+)\z/ }, uniqueness: true

  scope :for_entity, ->(taggable_type) { joins(:taggings).where(taggings: { taggable_type: taggable_type }) }
end
