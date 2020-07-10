class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :reviewed, class_name: 'User', foreign_key: :reviewed_id

  validates :rate, presence: true
end
