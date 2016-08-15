class ShareTask < ActiveRecord::Base
  validates :icon, :title, :link, :share_link, :share_icon, presence: true
  
  has_many :share_task_logs, dependent: :destroy
  
  scope :opened, -> { where(opened: true) }
  scope :sorted, -> { order('sort desc') }
  scope :recent, -> { order('id desc') }
  
  mount_uploader :icon, AvatarUploader
  mount_uploader :share_icon, AvatarUploader
  
  before_create :generate_task_id
  def generate_task_id
    # 生成8位数字任务ID
    begin
      self.task_id = '8' + rand.to_s[2..8] #if self.nb_code.blank?
    end while self.class.exists?(:task_id => task_id)
  end
  
  before_create :generate_dev_secret
  def generate_dev_secret
    # 生成20位密钥
    begin
      self.dev_secret = SecureRandom.hex(10) #if self.nb_code.blank?
    end while self.class.exists?(:dev_secret => dev_secret)
  end
  
  def add_visit
    self.class.increment_counter(:visit_count, self.id)
  end
  
  def my_total_income_for(uid)
    return 0 if uid.blank?
    @income ||= ShareTaskLog.where(uid: uid, share_task_id: self.id).first.try(:earn) || 0
  end
  
  def format_share_link_for(uid)
    return self.share_link if uid.blank?
    str = self.share_link
    if str.include? "?"
      str += "&uid=#{uid}"
    else
      str += "?uid=#{uid}"
    end
    str
  end
  
  def format_share_content_for(uid)
    "#{self.title} 点击链接......#{format_share_link_for(uid)}"
  end
  
end

# t.string :icon,     null: false
# t.string :title,    null: false
# t.integer :earn, default: 0
# t.integer :first_open_earn, default: 0
# t.integer :quantity, default: 0
# t.string :link, null: false
# t.string :share_content
# t.string :share_link, null: false
# t.string :share_icon, null: false
# t.integer :sort, default: 0
# t.boolean :opened, default: false
