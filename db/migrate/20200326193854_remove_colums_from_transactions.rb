class RemoveColumsFromTransactions < ActiveRecord::Migration[5.2]
  def change
    remove_column :transactions, :p1_id, :integer
    remove_column :transactions, :p2_id, :integer
    remove_column :transactions, :group_id, :integer
  end
end
