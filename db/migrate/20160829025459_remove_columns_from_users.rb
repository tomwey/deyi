class RemoveColumnsFromUsers < ActiveRecord::Migration
  def change
    remove_index :users, :mac_addr
    remove_column :users, :mac_addr
    remove_column :users, :wifi_length
    remove_index :users, :wifi_token
    remove_column :users, :wifi_token
  end
end
