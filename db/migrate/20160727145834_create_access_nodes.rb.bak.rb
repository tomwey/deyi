class CreateAccessNodes < ActiveRecord::Migration
  def change
    create_table :access_nodes do |t|
      t.string :name
      t.integer :sys_uptime
      t.integer :sys_load
      t.integer :sys_memfree
      t.integer :wifidog_uptime
      t.datetime :last_seen
      t.string :redirect_url
      t.string :mac
      t.references :user, index: true, foreign_key: true
      t.boolean :track_mac
      t.string :auth_mode
      t.string :remote_addr
      t.string :address
      t.integer :time_limit
      # t.integer :quota
      t.references :wifi_node, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
