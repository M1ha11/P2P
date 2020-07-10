class AddPartialIndexToUser < ActiveRecord::Migration[5.2]
  def change
    add_index :users, %i[email uid provider], unique: true
  end
end
