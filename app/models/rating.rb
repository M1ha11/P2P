class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :reviewed, class_name: 'User', foreign_key: :reviewed_id

  # enum rate: [1 2 3 4 5]
end
