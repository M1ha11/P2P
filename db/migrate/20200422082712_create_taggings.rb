class CreateTaggings < ActiveRecord::Migration[5.2]
  def change
    create_table :taggings do |t|

      t.timestamps
      t.references :tag
      t.references :taggable, polymorphic: true, index: true
    end
  end
end
