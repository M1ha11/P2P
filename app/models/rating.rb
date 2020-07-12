# == Schema Information
#
# Table name: ratings
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  rate        :integer
#  user_id     :bigint           not null
#  reviewed_id :integer          not null
#
class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :reviewed, class_name: 'User', foreign_key: :reviewed_id

  validates :rate, presence: true, inclusion: { in: (1..5) }
end
