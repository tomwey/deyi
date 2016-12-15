class RemoveColumnsFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :is_virtual_goods
    remove_index :products, :merchant_id
    remove_column :products, :merchant_id
  end
end
