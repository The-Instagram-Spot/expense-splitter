class RenameColumnsInAmounts < ActiveRecord::Migration[5.2]
  def change
    rename_column :amounts, :transactions_id, :transaction_id
    rename_column :amounts, :users_id, :user_id
  end
end
