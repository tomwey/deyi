class AddColumnsToAccessPoints < ActiveRecord::Migration
  def change
    add_column :access_points, :gw_mac, :string, unique: true
    add_column :access_points,:gw_address, :string, default: '192.168.8.1'
    add_column :access_points,:gw_port, :integer, default: 80
  end
end
