class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|

      t.timestamps
      t.string :card_number, limit: 16
      t.date :expire_date
      t.reference :user
    end
  end
end
