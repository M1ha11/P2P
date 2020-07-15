class AddRatableToRating < ActiveRecord::Migration[5.2]
  def change
    add_reference :ratings, :ratable, polymorphic: true
  end
end
