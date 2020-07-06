class CreateRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|

      t.timestamps
      t.integer :rate
      t.references :users, null: false, index: true
      t.integer :reviewed_id, foreign_key: true
    end
  end
end
