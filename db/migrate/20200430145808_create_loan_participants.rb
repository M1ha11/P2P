class CreateLoanParticipants < ActiveRecord::Migration[5.2]
  def change
    create_table :loan_participants do |t|

      t.timestamps, null: false
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :claim, index: true, foreign_key: true
      t.float :money
    end
  end
end
