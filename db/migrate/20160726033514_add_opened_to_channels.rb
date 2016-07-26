class AddOpenedToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :opened, :boolean, default: false
    change_column :channels, :support_os, :integer, default: 3
  end
end
