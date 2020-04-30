class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|

      t.timestamps
      t.string :name, limit: 50
      t.references :tagging, polymorphic: true
    end
  end
end
