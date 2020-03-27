class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|

      t.timestamps
      t.string :card_number, limit: 19, null: false
      t.string :expire_date, limit: 7, null: false
      t.references :user, foreign_key: true, null: false
    end
  end
end
