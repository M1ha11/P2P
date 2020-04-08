class CreateClaims < ActiveRecord::Migration[5.2]
  def change
    create_table :claims do |t|

      t.timestamps
      t.float :amount, null: false
      t.string :currency, null: false
      t.string :goal, null: false
      t.float :interest_rate, null: false
      t.string :repayment_period, null: false
      t.string :payment_frequency, null: false
      t.integer :status, null: false, default: 0
      t.references :user, foreign_key: true, null: false
    end
  end
end
