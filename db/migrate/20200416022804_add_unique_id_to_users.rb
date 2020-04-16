class AddUniqueIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :unique_id, :string
  end
end
