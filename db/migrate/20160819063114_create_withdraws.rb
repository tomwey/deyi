class CreateWithdraws < ActiveRecord::Migration
  def change
    create_table :withdraws do |t|
      t.references :withdraw_account, index: true, foreign_key: true
      t.integer :bean, null: false
      t.integer :fee, default: 0
      t.string :state, default: 'pending'
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
