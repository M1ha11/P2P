class RatingsController < ApplicationController
  def new
    @rating = current_user.ratings.new
    authorize @rating
  end

  def create
    @rating = current_user.ratings.new(rating_params)
    authorize @rating
    @rating.save
  end

  private

  def rating_params
    params.require(:rating).permit(:rate, :reviewed_id)
  end
end
