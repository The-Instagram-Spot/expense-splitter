class RemoveGroupIdFromPeople < ActiveRecord::Migration[5.2]
  def change
    remove_column :people, :group_id, :bigint
  end
end
