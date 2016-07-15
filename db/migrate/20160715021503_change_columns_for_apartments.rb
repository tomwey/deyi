class ChangeColumnsForApartments < ActiveRecord::Migration
  def change
    remove_index :apartments, :location
    remove_column :apartments, :location
    
    add_column :apartments, :location, :st_point, geographic: true
    add_index :apartments, :location, using: :gist
  end
end
