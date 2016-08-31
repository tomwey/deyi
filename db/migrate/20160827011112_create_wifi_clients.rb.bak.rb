class CreateWifiClients < ActiveRecord::Migration
  def change
    create_table :wifi_clients do |t|
      t.references :access_point, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer :kind, default: 1 # 客户端类型：1表示移动设备，2表示pc
      t.string :ip                # 连接设备的ip地址
      t.string :mac               # 连接设备的mac地址
      t.string :token
      t.integer :outgoing, default: 0 # 上传流量，单位 byte
      t.integer :incoming, default: 0 # 下载流量, 单位 byte
      t.integer :uprate, default: 0 # 上传速度
      t.integer :downrate, default: 0 # 下载速度
      t.integer :status, default: 1 # 登录状态 1表示登录请求 3表示计数状态
      t.integer :login_count, default: 0 # 登录次数
      t.datetime :used_at    # 登录时间
      t.datetime :expired_at # 连接失效时间

      t.timestamps null: false
    end
    add_index :wifi_clients, :token
  end
end
