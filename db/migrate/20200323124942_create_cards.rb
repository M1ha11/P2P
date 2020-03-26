class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|

      t.timestamps
      t.string :card_number, limit: 16, null: false
      t.date :expire_date, null: false
      t.references :user, foreign_key: true, null: false
    end
  end
end
