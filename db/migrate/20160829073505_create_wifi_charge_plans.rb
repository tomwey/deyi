class CreateWifiChargePlans < ActiveRecord::Migration
  def change
    create_table :wifi_charge_plans do |t|
      t.string :cid,   null: false, index: true, unique: true
      t.integer :cost, default: 5
      t.integer :hour, default: 1

      t.timestamps null: false
    end
  end
end
