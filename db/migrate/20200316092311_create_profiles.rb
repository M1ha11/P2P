class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.integer :success_credit_project, default: 0
      t.integer :success_lend_project, default: 0
      t.string :phone_number, null: false, limit: 25
      t.string :address, null: false, limit: 150
      t.string :avatar
      t.references :user, index: { unique: true }, foreign_key: true, null: false
      t.timestamps
    end
  end
end
