class ChangeColumnsForShareTaskLogs < ActiveRecord::Migration
  def change
    remove_index :share_task_logs, [:uid, :share_task_id]#, unique: true
    add_index :share_task_logs, [:uid, :share_task_id]
    add_column :share_task_logs, :order_no, :string, null: false
    add_index :share_task_logs, :order_no, unique: true
  end
end
