class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :text
      t.integer :parent_id, foreign_key: true
      t.references :user, foreign_key: true, null: false
      t.references :commentable, polymorphic: true
      t.timestamps
    end

    add_index :comments, :parent_id
    # add_foreign_key :comments, :parent_id
  end
end
