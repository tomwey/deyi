class AddReadSysMsgAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :read_sys_msg_at, :datetime
  end
end
