class FollowTask < ActiveRecord::Base
  validates :icon, :gzh_name, :gzh_id, :task_tip, presence: true
  
  has_many :follow_task_logs, dependent: :destroy
  
  mount_uploader :icon, AvatarUploader
  
  scope :opened, -> { where(opened: true) }
  scope :sorted, -> { order('sort desc') }
  scope :recent, -> { order('id desc') }
  
  before_create :generate_dev_secret
  def generate_dev_secret
    # 生成20位密钥
    begin
      self.dev_secret = SecureRandom.hex(10) #if self.nb_code.blank?
    end while self.class.exists?(:dev_secret => dev_secret)
  end
  
  def task_detail_url_for(uid)
    url = "#{SiteConfig.root_url || Setting.upload_url}/ft/#{self.id}"
    if uid.present?
      url += "?uid=#{uid}"
    end
    url
  end
end

# t.string :icon,       null: false # 公众号图标
# t.string :gzh_name,   null: false # 公众号名称
# t.string :gzh_id,     null: false # 公众号id
# t.string :gzh_intro
# t.integer :earn, default: 0
# t.text :task_tip,     null: false # 任务攻略
# t.string :dev_secret, null: false # 回调密钥，系统生成
# t.boolean :opened, default: false
# t.integer :sort, default: 0
