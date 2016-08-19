class CreateWithdrawAccounts < ActiveRecord::Migration
  def change
    create_table :withdraw_accounts do |t|
      t.string :name # 账号名
      t.string :account_id, null: false # 账号
      t.integer :account_type, default: 1 # 1 微信支付，2 支付宝支付
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :withdraw_accounts, [:account_type, :account_id], unique: true
  end
end
