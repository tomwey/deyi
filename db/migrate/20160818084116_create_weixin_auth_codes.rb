class CreateWeixinAuthCodes < ActiveRecord::Migration
  def change
    create_table :weixin_auth_codes do |t|
      t.string :openid, index: true
      t.string :code,   index: true
      t.datetime :actived_at
      t.datetime :expired_at

      t.timestamps null: false
    end
  end
end
