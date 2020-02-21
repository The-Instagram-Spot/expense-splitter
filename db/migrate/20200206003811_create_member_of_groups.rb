class CreateMemberOfGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :member_of_groups do |t|
      t.integer :group_id
      t.integer :person_id

      t.timestamps
    end
  end
end
