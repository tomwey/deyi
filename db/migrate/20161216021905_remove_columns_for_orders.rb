class RemoveColumnsForOrders < ActiveRecord::Migration
  def change
    remove_index :orders, :shipment_id
    remove_column :orders, :shipment_id
  end
end
