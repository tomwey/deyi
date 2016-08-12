class CreateAdTaskViewLogs < ActiveRecord::Migration
  def change
    create_table :ad_task_view_logs do |t|
      t.references :ad_task, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.st_point :location, geographic: true
      t.string :udid
      t.string :model
      t.string :os_version
      t.string :app_version
      t.string :screen_size
      t.string :country_language
      t.string :ip_addr
      t.string :network_type
      t.string :platform
      t.boolean :is_broken, default: false

      t.timestamps null: false
    end
    add_index :ad_task_view_logs, :location, using: :gist
  end
end
