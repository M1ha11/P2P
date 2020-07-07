module RatingsHelper
  def average_rate(user)
    Rating.where(reviewed_id: user.id).average(:rate).round(1)
  end
end
