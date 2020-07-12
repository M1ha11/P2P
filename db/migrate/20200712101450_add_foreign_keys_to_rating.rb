class AddForeignKeysToRating < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :ratings, :users, column: :reviewed_id
  end
end
