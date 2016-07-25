class AddVisitCountToProducts < ActiveRecord::Migration
  def change
    add_column :products, :visit_count, :integer, default: 0
    add_index :products, :visit_count
  end
end
