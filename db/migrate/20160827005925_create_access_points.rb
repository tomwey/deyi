class CreateAccessPoints < ActiveRecord::Migration
  def change
    create_table :access_points do |t|
      t.string :name
      t.integer :sys_uptime
      t.integer :sys_load
      t.integer :sys_memfree
      t.integer :wifidog_uptime
      t.integer :cpu_usage
      t.integer :client_count, default: 0 # 连接设备数量
      t.integer :conn_count, default: 0   # 网络连接数
      t.datetime :update_time
      t.string :gw_id, unique: true # 网关的mac
      t.string :dev_id # 路由器设备id
      t.string :dev_md5 # device_token, 对dev_id加密所得
      t.references :wifi_node, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
