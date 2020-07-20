class CreateRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|

      t.timestamps null: false
      t.integer :rate, null: false
      t.references :user, null: false, index: true, foreign_key: true
      t.integer :reviewed_id, null: false, index: true
    end
  end
end
