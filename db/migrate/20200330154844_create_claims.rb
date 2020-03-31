class CreateClaims < ActiveRecord::Migration[5.2]
  def change
    create_table :claims do |t|

      t.timestamps
      t.float :amount
      t.string :currency
      t.string :goal
      t.float :interest_rate
      t. :repaiment_period
      t. :payment_frequency
      t. :status
    end
  end
end
