class CreateFollowTaskLogs < ActiveRecord::Migration
  def change
    create_table :follow_task_logs do |t|
      t.string :uid, index: true
      t.references :follow_task, index: true, foreign_key: true
      t.integer :earn
      t.string :callback_params, array: true, default: []

      t.timestamps null: false
    end
    add_index :follow_task_logs, [:uid, :follow_task_id], unique: true
  end
end
