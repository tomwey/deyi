class RemoveColumnsFromEarnLogs < ActiveRecord::Migration
  def change
    remove_column :earn_logs, :udid
    remove_column :earn_logs, :model
    remove_column :earn_logs, :os_version
    remove_column :earn_logs, :app_version
    remove_column :earn_logs, :screen_size
    remove_column :earn_logs, :country_language
    remove_column :earn_logs, :ip_addr
    remove_column :earn_logs, :network_type # 网络类型，可能的值有WIFI, 3G, 4G
    remove_column :earn_logs, :is_broken
  end
end
