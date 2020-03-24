class CreateAmounts < ActiveRecord::Migration[5.2]
  def change
    create_table :amounts do |t|
      t.belongs_to :transactions
      t.belongs_to :users
      t.decimal :difference
      t.timestamps
    end
  end
end
