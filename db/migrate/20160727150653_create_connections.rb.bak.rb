class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.string :token
      t.string :remote_addr
      t.integer :gw_id, default: 0
      t.datetime :expired_at
      t.references :user, index: true, foreign_key: true
      t.datetime :used_at
      t.string :ip
      t.string :mac
      t.integer :incoming_bytes, default: 0
      t.integer :outgoing_bytes, default: 0
      t.references :access_node, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
