class CreateAppVersions < ActiveRecord::Migration
  def change
    create_table :app_versions do |t|
      t.string :os, null: false # 系统，值为android或ios
      t.string :version, null: false # 当前版本
      t.text :changelog, null: false # 当前版本更新的内容
      t.string :file # 安装包文件，如果是iOS可以为空
      t.boolean :must_upgrade, default: true # 是否必须升级该版本
      t.integer :mode, default: 0 # 该版本用于哪个模式，0表示开发模式，1表示产品模式

      t.timestamps null: false
    end
    add_index :app_versions, [:os, :version, :mode], unique: true
  end
end
