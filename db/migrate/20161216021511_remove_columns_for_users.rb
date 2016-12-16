class RemoveColumnsForUsers < ActiveRecord::Migration
  def change
    remove_index :users, :current_shipment_id
    remove_column :users, :current_shipment_id
  end
end
