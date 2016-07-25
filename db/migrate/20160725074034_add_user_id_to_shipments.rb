class AddUserIdToShipments < ActiveRecord::Migration
  def change
    add_column :shipments, :user_id, :integer
    add_index :shipments, :user_id
  end
end
