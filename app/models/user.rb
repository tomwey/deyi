class User < ActiveRecord::Base  
  has_secure_password
  
  attr_accessor :money
  
  validates :mobile, :password, :password_confirmation, presence: true, on: :create
  validates :mobile, format: { with: /\A1[3|4|5|7|8][0-9]\d{4,8}\z/, message: "请输入11位正确手机号" }, length: { is: 11 }, :uniqueness => true
            
  mount_uploader :avatar, AvatarUploader
  
  scope :no_delete, -> { where(visible: true) }
  scope :verified,  -> { where(verified: true) }
  
  has_many :connections
  
  has_many :invites, foreign_key: 'inviter_id', dependent: :destroy
  
  # 有一个邀请者
  belongs_to :inviter,       class_name: 'User', foreign_key: 'inviter_id'
  
  # 有许多邀请过的用户
  has_many   :invited_users, class_name: 'User', foreign_key: 'inviter_id'
  
  def invite!(invitee)
    return false if invitee.blank?
    return false if invitee == self
    
    # 检测是否已经被邀请过
    if invitee.inviter_id.present?
      return false
    end
    
    User.transaction do
      invitee.inviter_id = self.id
      invitee.save!
      
      Invite.create!(inviter_id: self.id, invitee_id: invitee.id)
    end
    
    return true
  end
  
  def hack_mobile
    return "" if self.mobile.blank?
    hack_mobile = String.new(self.mobile)
    hack_mobile[3..6] = "****"
    hack_mobile
  end
  
  def real_avatar_url(size = :large)
    if avatar.blank?
      "avatar/#{size}.png"
    else
      avatar.url(size)
    end
  end
  
  # 获取默认的收货地址
  def current_shipment
    @current_shipment ||= Shipment.find_by(id: self.current_shipment_id)
  end
  
  # 生成token
  before_create :generate_private_token
  def generate_private_token
    self.private_token = SecureRandom.uuid.gsub('-', '') if self.private_token.blank?
  end
  
  # 生成唯一的优惠推荐码
  before_create :generate_nb_code
  def generate_nb_code
    # 生成6位随机码, 系统的推荐码是5位数
    begin
      self.nb_code = SecureRandom.hex(3) #if self.nb_code.blank?
    end while self.class.exists?(:nb_code => nb_code)
  end
  
  # 设置uid
  after_save :set_uid_if_needed
  def set_uid_if_needed
    if self.uid.blank?
      self.uid = 10000000 + self.id
      self.save!
      
      # 生成二维码
      CreateQrcodeJob.perform_later(self)
    end
  end
  
  # 返回二维码图片地址
  def qrcode_url
    SiteConfig.root_url || Setting.upload_url + "/uploads/user/#{self.uid}/qrcode.png"
  end
  
  # 禁用账户
  def block!
    self.verified = false
    self.save!
  end
  
  # 启用账户
  def unblock!
    self.verified = true
    self.save!
  end
  
  def change_balance!(total)
    dt = self.balance + total
    if dt >= 0
      self.balance = dt
      self.save!
    end
  end
  
  def expire_all_connections
    self.connections.each { |c| c.expire! }
  end
  
  # 设置支付密码
  # def pay_password=(password)
  #   self.pay_password_digest = BCrypt::Password.create(password) if self.pay_password_digest.blank?
  # end
  
  # 更新支付密码
  def update_pay_password!(password)
    return false if password.blank?
    self.pay_password_digest = BCrypt::Password.create(password)
    self.save!
  end
  
  # 检查支付密码是否正确
  def is_pay_password?(password)
    return false if self.pay_password_digest.blank?
    BCrypt::Password.new(self.pay_password_digest) == password
  end
  
  def today_beans    
     sum = EarnLog.where(user_id: self.id, created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).sum(:earn)
     sum
  end
  
end
