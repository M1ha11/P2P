class ChangeEmailIndexFromUser < ActiveRecord::Migration[5.2]
  def up
    remove_index :users, :email
    add_index :users, :email, unique: true, where: 'provider is null'
  end

  def down
    remove_index :users, :email
    add_index :users, :email, unqiue: true
  end
end
