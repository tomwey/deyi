class CreateAppTypes < ActiveRecord::Migration
  def change
    create_table :app_types do |t|
      t.string :name
      t.integer :parent_id
      t.string :icon
      t.integer :sort, default: 0
      t.boolean :opened, default: true

      t.timestamps null: false
    end
    add_index :app_types, :parent_id
  end
end
