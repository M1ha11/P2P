# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  text             :string           not null
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
  belongs_to :parent, optional: true, class_name: 'Comment'
  has_many :childs, class_name: 'Comment', foreign_key: :parent_id, dependent: :destroy
  has_one :profile, through: :user

  delegate :avatar, to: :profile

  validates :text, presence: true

  scope :top_level_comment, -> { where(parent_id: nil) }

  MAX_LEVEL = 3
end
