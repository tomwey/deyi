class AddNbCodeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :nb_code, :string
    add_index :users, :nb_code, unique: true # 邀请码
  end
end
