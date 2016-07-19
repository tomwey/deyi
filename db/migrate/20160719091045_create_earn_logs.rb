class CreateEarnLogs < ActiveRecord::Migration
  def change
    create_table :earn_logs do |t|
      t.references :user, index: true, foreign_key: true
      t.references :earnable, polymorphic: true
      t.integer :earn
      t.string :udid
      t.string :model
      t.string :os_version
      t.string :app_version
      t.string :screen_size
      t.string :country_language
      t.string :ip_addr
      t.string :network_type # 网络类型，可能的值有WIFI, 3G, 4G
      t.boolean :is_broken, default: false # 是否越狱

      t.timestamps null: false
    end
  end
end
