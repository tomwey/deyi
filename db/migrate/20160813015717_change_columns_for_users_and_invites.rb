class ChangeColumnsForUsersAndInvites < ActiveRecord::Migration
  def change
    add_column :users, :inviter_id, :integer
    add_index  :users, :inviter_id
  end
end
