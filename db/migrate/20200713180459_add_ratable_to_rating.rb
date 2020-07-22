class AddRatableToRating < ActiveRecord::Migration[5.2]
  def change
    add_reference :ratings, :ratable, polymorphic: true, null: false, index: false
    add_index :ratings, %i[ratable_type ratable_id user_id reviewed_id], unique: true,
      name: 'index_ratings_on_ratable_and_user_id_and_reviewed_id'
  end
end
