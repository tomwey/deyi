class AddTitleToEarnLogs < ActiveRecord::Migration
  def change
    add_column :earn_logs, :title, :string
  end
end
