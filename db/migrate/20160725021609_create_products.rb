class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title, null: false
      t.text :body,    null: false
      t.integer :price, null: false
      t.integer :sort, default: 0
      t.string :image, null: false
      t.string :sku
      t.integer :orders_count, default: 0
      t.boolean :on_sale, default: false
      t.boolean :visible, default: true
      t.integer :stock, default: 1000 # 库存
      t.boolean :is_virtual_goods, default: false

      t.timestamps null: false
    end
    add_index :products, :sku, unique: true
    add_index :products, :sort
    add_index :products, :orders_count
  end
end
