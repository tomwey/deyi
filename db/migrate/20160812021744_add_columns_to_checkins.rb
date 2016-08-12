class AddColumnsToCheckins < ActiveRecord::Migration
  def change
    add_column :checkins, :udid, :string
    add_column :checkins, :model, :string
    add_column :checkins, :os_version, :string
    add_column :checkins, :app_version, :string
    add_column :checkins, :screen_size, :string
    add_column :checkins, :country_language, :string
    add_column :checkins, :ip_addr, :string
    add_column :checkins, :network_type, :string
    add_column :checkins, :platform, :string
    add_column :checkins, :is_broken, :boolean, default: false
  end
end
