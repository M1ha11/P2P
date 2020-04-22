class Tag < ApplicationRecord
  has_many :taggings
  has_many :claims, through: :tagging, source: :taggable, source_type: 'Claim'
end
