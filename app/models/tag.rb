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
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  has_many :taggings
  has_many :taggable, through: :taggings

  validates :name, presence: true, format: { with: /\A(#\w+)\z/ }, uniqueness: true

  scope :for_entity, ->(taggable_type) { joins(:taggings).where(taggings: { taggable_type: taggable_type }) }

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :name, analyzer: 'simple', search_analyzer: 'simple'
    end
  end

  after_commit :index_document, if: :persisted?
  after_commit on: [:destroy] do
    __elasticsearch__.delete_document
  end

  private

  def index_document
    __elasticsearch__.index_document
  end
end
