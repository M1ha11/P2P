# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  text             :string
#  parent_id        :integer
#  user_id          :bigint           not null
#  commentable_type :string
#  commentable_id   :bigint
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  belongs_to :parent, optional: true, class_name: "Comment"
  has_many :child, class_name: 'Comment', foreign_key: :parent_id, dependent: :destroy

  delegate :profile, to: :user

  acts_as_tree order: 'created_at DESC'

  validates :text, presence: true
end
