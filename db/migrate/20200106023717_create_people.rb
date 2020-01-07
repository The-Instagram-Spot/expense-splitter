class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.string :name
      t.string :email
      t.references :group, foreign_key: true

      t.timestamps
    end
  end
end
