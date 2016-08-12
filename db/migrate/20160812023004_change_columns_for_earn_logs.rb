class ChangeColumnsForEarnLogs < ActiveRecord::Migration
  def change
    remove_column :earn_logs, :platform
    add_column :earn_logs, :subtitle, :string
  end
end
