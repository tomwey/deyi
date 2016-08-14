class CreateShareTaskLogs < ActiveRecord::Migration
  def change
    create_table :share_task_logs do |t|
      t.string :uid
      t.references :share_task, index: true, foreign_key: true
      t.integer :earn
      t.string :callback_params, array: true, default: []

      t.timestamps null: false
    end
    add_index :share_task_logs, :uid
    add_index :share_task_logs, [:uid, :share_task_id], unique: true
  end
end
