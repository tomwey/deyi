class CreateProductModes < ActiveRecord::Migration
  def change
    create_table :product_modes do |t|
      t.string :name, null: false
      t.integer :sort, default: 0

      t.timestamps null: false
    end
  end
end
