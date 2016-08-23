class AddFacilitiesToApartments < ActiveRecord::Migration
  def change
    add_column :apartments, :facilities, :string, array: true, default: []
  end
end
