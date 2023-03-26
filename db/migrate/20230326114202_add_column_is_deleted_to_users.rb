class AddColumnIsDeletedToUsers < ActiveRecord::Migration[6.1]
  def up
    add_column :users, :is_deleted, :boolean
  end
  
  def down
    remove_column :users, :is_deleted, :boolean
  end
end
