class CreateTaggings < ActiveRecord::Migration[5.2]
  def change
    create_table :taggings do |t|

      t.timestamps
      t.references :tag, null: false, index: true
      t.references :taggable, polymorphic: true, null: false
    end
  end
end
