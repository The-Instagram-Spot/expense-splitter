class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :transaction_id
      t.integer :p1_id
      t.integer :p2_id
      t.integer :group_id
      t.decimal :amount

      t.timestamps
    end
  end
end
