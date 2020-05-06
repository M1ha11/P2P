class Tag < ApplicationRecord
  belongs_to :taggable, polymorphic: true

  validates :name, presence: true, format: { with: /\A(#\w+)\z/ }
end
