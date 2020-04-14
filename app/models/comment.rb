class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :claim
  belongs_to :parent, optional: true, class_name: "Comment"
  has_many :replies, class_name: 'Comment', foreign_key: :parent_id, dependent: :destroy

  validates :text, presence: true
end
