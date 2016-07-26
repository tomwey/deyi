class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :name,        null: false
      t.integer :support_os, null: false
      t.string :title,       null: false
      t.string :subtitle
      t.integer :sort, default: 0
      t.string :icon
      t.string :ios_app_name
      t.string :ios_app_id
      t.string :ios_app_secret
      t.string :ios_other
      t.string :android_app_name
      t.string :android_app_id
      t.string :android_app_secret
      t.string :android_other
      t.string :user_param,     null: false # 用户id回调参数
      t.string :point_param,    null: false # 积分回调参数
      t.string :app_id_param,   null: false # appid回调参数
      t.string :app_name_param, null: false # 应用名回调参数
      t.string :ip_param
      t.string :success_return, null: false # 返回成功结果描述
      t.string :fail_return,    null: false # 返回失败结果描述
      t.string :callback_uri,   null: false

      t.timestamps null: false
    end
    add_index :channels, :sort
  end
end
