class CreateWifiNodes < ActiveRecord::Migration
  def change
    create_table :wifi_nodes do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.st_point :location, geographic: true
      # t.string :ssid, null: false

      t.timestamps null: false
    end
    add_index :wifi_nodes, :location, using: :gist
  end
end
