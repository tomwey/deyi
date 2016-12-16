class RenameColumnForProducts < ActiveRecord::Migration
  def change
    rename_column :products, :stock, :stocks_count
  end
end
