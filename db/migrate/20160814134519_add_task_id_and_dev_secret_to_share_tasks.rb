class AddTaskIdAndDevSecretToShareTasks < ActiveRecord::Migration
  def change
    add_column :share_tasks, :task_id, :string, null: false
    add_index :share_tasks, :task_id, unique: true
    add_column :share_tasks, :dev_secret, :string, null: false
    add_index :share_tasks, :dev_secret, unique: true
  end
end
