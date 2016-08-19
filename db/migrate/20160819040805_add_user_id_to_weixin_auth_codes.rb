class AddUserIdToWeixinAuthCodes < ActiveRecord::Migration
  def change
    add_column :weixin_auth_codes, :user_id, :integer
    add_index :weixin_auth_codes, :user_id
    add_index :weixin_auth_codes, [:openid, :user_id], unique: true
  end
end
