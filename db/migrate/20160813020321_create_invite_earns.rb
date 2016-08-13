class CreateInviteEarns < ActiveRecord::Migration
  def change
    create_table :invite_earns do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :invitee_id
      t.integer :earn

      t.timestamps null: false
    end
    add_index :invite_earns, :invitee_id
  end
end
