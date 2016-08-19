class AddAccountTypeToWithdraws < ActiveRecord::Migration
  def change
    add_column :withdraws, :account_type, :integer, default: 1
  end
end
