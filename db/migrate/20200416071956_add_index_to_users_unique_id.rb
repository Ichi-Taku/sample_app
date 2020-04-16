class AddIndexToUsersUniqueId < ActiveRecord::Migration[5.1]
  def change
    add_index :users, :unique_id, unique: true
  end
end
