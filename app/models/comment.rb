class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  belongs_to :parent, optional: true, class_name: "Comment"
  has_many :child, class_name: 'Comment', foreign_key: :parent_id, dependent: :destroy

  acts_as_tree order: 'created_at DESC'

  validates :text, presence: true
end
