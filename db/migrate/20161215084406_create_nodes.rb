class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string :name, null: false
      t.integer :sort, default: 0

      t.timestamps null: false
    end
    add_index :nodes, :sort
  end
end
