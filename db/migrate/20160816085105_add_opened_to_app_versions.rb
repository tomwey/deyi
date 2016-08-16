class AddOpenedToAppVersions < ActiveRecord::Migration
  def change
    add_column :app_versions, :opened, :boolean, default: false
  end
end
