class CreateAdTasks < ActiveRecord::Migration
  def change
    create_table :ad_tasks do |t|
      t.string :title, null: false
      t.string :subtitle
      t.st_point :location, geographic: true
      t.string :cover_image, null: false
      t.integer :price, default: 0
      t.integer :share_price, default: 0 # 分享赚钱
      t.integer :ad_type, default: 1     # 1 图片广告，2 网页广告，3 视频广告
      t.string :ad_contents, array: true, default: []
      t.string :ad_link
      t.date :expired_on
      t.integer :sort, default: 0
      t.integer :view_count, default: 0
      t.boolean :opened, default: false
      t.integer :owner_id

      t.timestamps null: false
    end
    add_index :ad_tasks, :location, using: :gist
    add_index :ad_tasks, :sort
    add_index :ad_tasks, :owner_id
  end
end
