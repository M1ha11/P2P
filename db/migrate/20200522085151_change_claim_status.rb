class ChangeClaimStatus < ActiveRecord::Migration[5.2]
  def up
    change_column :claim, :status, :string, default: 'publicly', null: false
  end

  def down
    change_column :claims, :status, :integer
  end
end
