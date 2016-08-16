class Channel < ActiveRecord::Base
  validates :name, :support_os, :title, :user_param, :point_param, :app_id_param, :app_name_param, :success_return, :fail_return, presence: true
  
  scope :opened, -> { where(opened: true) }
  scope :sorted, -> { order('sort desc') }
  scope :recent, -> { order('id desc') }
  scope :list_for_os, -> (os_type) { where(support_os: ( [3] << os_type ) ) }
  
  mount_uploader :icon, AvatarUploader
  
  def self.preferred_support_os
    [['苹果系统', 1], ['安卓系统', 2], ['双系统', 3]]
  end
  
  def self.preferred_names
    ['点入', '有米', '趣米', '点乐', '指盟', '贝多', '万普']
  end
  
  def support_os_info
    case self.support_os
    when 1 then '苹果系统'
    when 2 then '安卓系统'
    when 3 then '双系统'
    else ''
    end
  end
  
  def close!
    self.opened = false
    self.save!
  end
  
  def open!
    self.opened = true
    self.save!
  end
  
end

# t.string :name,        null: false
# t.integer :support_os, null: false
# t.string :title,       null: false
# t.string :subtitle
# t.integer :sort, default: 0
# t.string :icon
# t.string :ios_app_name
# t.string :ios_app_id
# t.string :ios_app_secret
# t.string :ios_other
# t.string :android_app_name
# t.string :android_app_id
# t.string :android_app_secret
# t.string :android_other
# t.string :user_param,     null: false # 用户id回调参数
# t.string :point_param,    null: false # 积分回调参数
# t.string :app_id_param,   null: false # appid回调参数
# t.string :app_name_param, null: false # 应用名回调参数
# t.string :ip_param
# t.string :success_return, null: false # 返回成功结果描述
# t.string :fail_return,    null: false # 返回失败结果描述
# t.string :callback_uri,   null: false
