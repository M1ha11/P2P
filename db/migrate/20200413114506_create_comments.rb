class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :text
      t.integer :parent_id, foreign_key: true
      t.references :user, foreign_key: true, null: false
      t.references :claim, foreign_key: true, null: false
      t.timestamps
    end
  end
end
