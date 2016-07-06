class AddMacAddrAndWifiLengthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mac_addr, :string # Mac上网地址
    add_index  :users, :mac_addr
    add_column :users, :wifi_length, :integer, default: 0 # 上网时长，单位为分钟
  end
end
