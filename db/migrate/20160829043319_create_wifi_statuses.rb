class CreateWifiStatuses < ActiveRecord::Migration
  def change
    create_table :wifi_statuses do |t|
      t.references :user, index: true, foreign_key: true
      t.string :token
      t.boolean :online, default: false  # 是否正在上网
      t.integer :wifi_length, default: 0 # 剩下的上网时间，单位分钟
      t.integer :login_count, default: 0 # 上网次数
      t.datetime :last_login_at          # 最后一次上网的时间
      t.timestamps null: false
    end
    add_index :wifi_statuses, :token, unique: true
  end
end
