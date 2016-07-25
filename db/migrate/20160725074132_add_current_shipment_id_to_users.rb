class AddCurrentShipmentIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :current_shipment_id, :integer
    add_index :users, :current_shipment_id
  end
end
