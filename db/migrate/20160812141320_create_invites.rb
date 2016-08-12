class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.integer :inviter_id
      t.integer :invitee_id

      t.timestamps null: false
    end
    add_index :invites, :inviter_id
    add_index :invites, :invitee_id
    add_index :invites, [:inviter_id, :invitee_id], unique: true
  end
end
