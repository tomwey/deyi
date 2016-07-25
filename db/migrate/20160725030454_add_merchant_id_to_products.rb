class AddMerchantIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :merchant_id, :integer
    add_index :products, :merchant_id
  end
end
