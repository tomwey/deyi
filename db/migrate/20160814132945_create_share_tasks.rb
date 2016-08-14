class CreateShareTasks < ActiveRecord::Migration
  def change
    create_table :share_tasks do |t|
      t.string :icon,     null: false
      t.string :title,    null: false
      t.integer :earn, default: 0
      t.integer :first_open_earn, default: 0
      t.integer :quantity, default: 0
      t.string :link, null: false
      t.string :share_content
      t.string :share_link, null: false
      t.string :share_icon, null: false
      t.integer :sort, default: 0
      t.boolean :opened, default: false

      t.timestamps null: false
    end
    add_index :share_tasks, :sort
  end
end
