class AddNeedUserInputToProductModes < ActiveRecord::Migration
  def change
    add_column :product_modes, :need_user_input, :boolean, default: false
  end
end
