class RatingsController < ApplicationController
  def new
    @rates = Rating.rates.keys
    @rating = current_user.ratings.new
  end

  def create
    @rating = current_user.ratings.new(rating_params)
    @rating.save
  end

  private

  def rating_params
    params.require(:rating).permit(:rate, :reviewed_id)
  end
end
