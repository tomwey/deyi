class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :content, null: false
      t.integer :to
      t.datetime :read_at

      t.timestamps null: false
    end
    add_index :messages, :to
  end
end
