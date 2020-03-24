class AddNameToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :name, :string
  end
end
