class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :name, null: false
      t.references :product, index: true, foreign_key: true
      t.boolean :valid, default: true

      t.timestamps null: false
    end
  end
end
