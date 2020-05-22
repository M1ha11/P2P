class ChangeClaimStatus < ActiveRecord::Migration[5.2]
  def change
    remove_column :claims, :status
    add_column :claims, :status, :string, default: 'publicly', null: false
  end
end
