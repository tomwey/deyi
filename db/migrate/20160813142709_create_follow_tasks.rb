class CreateFollowTasks < ActiveRecord::Migration
  def change
    create_table :follow_tasks do |t|
      t.string :icon,       null: false # 公众号图标
      t.string :gzh_name,   null: false # 公众号名称
      t.string :gzh_id,     null: false # 公众号id
      t.string :gzh_intro
      t.integer :earn, default: 0
      t.text :task_tip,     null: false # 任务攻略
      t.string :dev_secret, null: false # 回调密钥，系统生成
      t.boolean :opened, default: false
      t.integer :sort, default: 0

      t.timestamps null: false
    end
    add_index :follow_tasks, :gzh_id,     unique: true
    add_index :follow_tasks, :dev_secret, unique: true
    add_index :follow_tasks, :sort
  end
end
