module RatingsHelper
  def average_rate(user)
    @rating = Rating.where(reviewed_id: user.id).average(:rate)
    @rating.round(1) unless @rating.nil?
  end
end
