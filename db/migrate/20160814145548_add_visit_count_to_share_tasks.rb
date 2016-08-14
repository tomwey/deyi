class AddVisitCountToShareTasks < ActiveRecord::Migration
  def change
    add_column :share_tasks, :visit_count, :integer, default: 0
  end
end
