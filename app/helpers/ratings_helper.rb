module RatingsHelper
  def average_rate(user)
    @rating = Rating.where(reviewed_id: user.id).average(:rate)
    @rating.round(1) unless @rating.nil?
  end

  def rating_not_exist(ratable_type, ratable_id, reviewed_id)
    Rating.find_by(ratable_type: ratable_type.to_s, ratable_id: ratable_id, reviewed_id: reviewed_id).nil?
  end
end
