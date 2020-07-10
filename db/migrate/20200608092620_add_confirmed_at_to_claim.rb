class AddConfirmedAtToClaim < ActiveRecord::Migration[5.2]
  def change
    add_column :claims, :confirmed_at, :datetime
  end
end
