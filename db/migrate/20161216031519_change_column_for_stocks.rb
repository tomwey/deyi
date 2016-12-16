class ChangeColumnForStocks < ActiveRecord::Migration
  def change
    remove_column :stocks, :valid
    add_column :stocks, :outgoing, :boolean, default: false # 是否出库
  end
end
