class AddPaidToAmounts < ActiveRecord::Migration[5.2]
  def change
    add_column :amounts, :paid, :decimal
  end
end
