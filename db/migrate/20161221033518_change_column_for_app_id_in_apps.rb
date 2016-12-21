class ChangeColumnForAppIdInApps < ActiveRecord::Migration
  def change
    change_column :apps, :app_id, :string
  end
end
