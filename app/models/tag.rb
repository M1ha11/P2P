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
  include Searchable

  has_many :taggings, dependent: :destroy
  has_many :taggable, through: :taggings

  validates :name, presence: true, format: { with: /\A(#\w+)\z/ }, uniqueness: true

  scope :for_entity, ->(taggable_type) { joins(:taggings).where(taggings: { taggable_type: taggable_type }) }

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :name, analyzer: 'simple', search_analyzer: 'simple'
    end
  end
end
