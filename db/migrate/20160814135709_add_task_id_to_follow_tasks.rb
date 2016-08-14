class AddTaskIdToFollowTasks < ActiveRecord::Migration
  def change
    add_column :follow_tasks, :task_id, :string#, null: false
    add_index :follow_tasks, :task_id, unique: true
  end
end
