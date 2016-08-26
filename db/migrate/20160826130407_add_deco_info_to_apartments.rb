class AddDecoInfoToApartments < ActiveRecord::Migration
  def change
    add_column :apartments, :deco_info, :string
  end
end
