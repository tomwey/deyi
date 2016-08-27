class AppVersion < ActiveRecord::Base
  
  validates :os, :version, :changelog, presence: true
  
  mount_uploader :file, AppPackageUploader
  
  scope :opened, -> { where(opened: true) }
  
  def version_summary_url
    SiteConfig.root_url || Setting.upload_url + "/version/info?os=#{self.os}&bv=#{self.version}&m=#{self.mode}"
  end
  
  def self.preferred_os_names
    app_platform = SiteConfig.app_platforms || 'iOS,Android'
    app_platform.split(',')
  end
  
  def self.preferred_modes
    [['开发模式', 0], ['产品模式', 1]]
  end
  
  def self.latest_version
    order('version desc').first
  end
  
end

# t.string :os, null: false # 系统，值为android或ios
# t.string :version, null: false # 当前版本
# t.text :changelog, null: false # 当前版本更新的内容
# t.string :file # 安装包文件，如果是iOS可以为空
# t.boolean :must_upgrade, default: true # 是否必须升级该版本
# t.integer :mode, default: 0 # 该版本用于哪个模式，0表示开发模式，1表示产品模式
