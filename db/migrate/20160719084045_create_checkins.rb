class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.references :user, index: true, foreign_key: true
      t.st_point :location, geographic: true
      t.integer :earn

      t.timestamps null: false
    end
    add_index :checkins, :location, using: :gist
  end
end
