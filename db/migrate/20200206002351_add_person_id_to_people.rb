class AddPersonIdToPeople < ActiveRecord::Migration[5.2]
  def change
    add_column :people, :person_id, :int
  end
end
