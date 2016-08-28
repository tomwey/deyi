class AddWifiTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :wifi_token, :string
    add_index :users, :wifi_token, unique: true
  end
end
