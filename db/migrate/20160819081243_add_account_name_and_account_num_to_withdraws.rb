class AddAccountNameAndAccountNumToWithdraws < ActiveRecord::Migration
  def change
    add_column :withdraws, :account_name, :string, null: false
    add_column :withdraws, :account_num, :string,  null: false
    remove_index :withdraws, :withdraw_account_id
    remove_column :withdraws, :withdraw_account_id
  end
end
