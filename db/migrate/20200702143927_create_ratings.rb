class CreateRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|

      t.timestamps
      t.integer rate
      t.references :claim, null: false, index: true
      t.references :user, null: false, index: true
    end
  end
end
