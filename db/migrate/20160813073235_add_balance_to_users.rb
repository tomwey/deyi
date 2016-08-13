class AddBalanceToUsers < ActiveRecord::Migration
  def change
    add_column :users, :balance, :integer, default: 0
    add_index  :users, :bean
  end
end
