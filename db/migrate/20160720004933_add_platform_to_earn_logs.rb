class AddPlatformToEarnLogs < ActiveRecord::Migration
  def change
    add_column :earn_logs, :platform, :string
  end
end
