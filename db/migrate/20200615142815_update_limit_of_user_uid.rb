class UpdateLimitOfUserUid < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :uid, :string, limit: 50
  end

  def down
    change_column :users, :uid, :string, limit: 10
  end
end
