class Tag < ApplicationRecord
  belongs_to :tagging, polymorphic: true

  validates :name, presence: true, uniqueness: true
end
