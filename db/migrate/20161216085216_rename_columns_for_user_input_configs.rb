class RenameColumnsForUserInputConfigs < ActiveRecord::Migration
  def change
    rename_column :user_input_configs, :label, :input_label
    rename_column :user_input_configs, :placeholder, :input_placeholder
  end
end
