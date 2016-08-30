class AddWmacToAccessPoints < ActiveRecord::Migration
  def change
    add_column :access_points, :wmac, :string
    add_index :access_points, :wmac, unique: true
  end
end
