class CreateUserInputConfigs < ActiveRecord::Migration
  def change
    create_table :user_input_configs do |t|
      t.string :label, null: false
      t.string :placeholder
      t.references :product, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
