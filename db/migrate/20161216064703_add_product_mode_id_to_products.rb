class AddProductModeIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :product_mode_id, :integer
    add_index :products, :product_mode_id
  end
end
