class CreateWifiLogs < ActiveRecord::Migration
  def change
    create_table :wifi_logs do |t|
      t.references :user, index: true, foreign_key: true
      t.references :access_point, index: true, foreign_key: true
      t.datetime :used_at
      t.datetime :expired_at
      t.string :ip
      t.string :mac
      t.integer :incoming_bytes, default: 0
      t.integer :outgoing_bytes, default: 0

      t.timestamps null: false
    end
  end
end
