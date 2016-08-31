require 'rest-client'
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
  
  # has_one :wifi_status, dependent: :destroy
  has_many :connections, class_name: 'WifiLog', foreign_key: 'user_id'
  
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
  
  # 连接到得益wifi
  def open_wifi(gw_mac)
    # return { code: -1, message: '热点MAC地址为空' } if gw_mac.blank?
    # @ap = AccessPoint.find_by(gw_mac: gw_mac)
    # return { code: 4004, message: '未找到热点' } if @ap.blank?
    #
    # self.update_wifi_token! if self.wifi_token.blank?
    # gw_url = "http://#{@ap.gw_address}:#{@ap.gw_port}/wifidog/auth?token=#{self.wifi_token}"
    # RestClient.get url
    
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
  
  # 该用户是否正在上网
  def has_connected_wifi?
    connections.where(expired_at: nil).count > 0
  end
  
  # 充网时
  def charge_wifi_length!(wifi_length)
    return false if wifi_status.blank?
    
    wifi_status.change_wifi_length!(wifi_length)
    
    return true
  end
  
  def connect_wifi!
    if wifi_status.present?
      wifi_status.add_login_count
      wifi_status.last_login_at = Time.zone.now
      wifi_status.save!
    end
  end
  
  def close_wifi!
    if wifi_status.present?
      wifi_status.online = false
      wifi_status.save!
    end
  end
  
  # 获取用户的当前wifi状态
  def wifi_status
    @wifi_status ||= WifiStatus.where(user_id: self.id).first_or_create
  end
  
  # 获取当前打开的连接
  def current_connection
    @log ||= WifiLog.where(expired_at: nil).first
  end
  
  def current_connection_for(ap)
    return nil if ap.blank?
    @connection ||= self.connections.where(access_point: ap.id, expired_at: nil).first
  end
  
  def close_connection
    current_connection.close!
  end
  
  # 是否足够的上网时间
  def has_enough_wifi_length?    
    (wifi_status.wifi_length >= min_allowed_wifi_length)
  end
  
  # 最低上网时长
  def min_allowed_wifi_length
    (CommonConfig.min_allowed_wifi_length || 30).to_i
  end
  
  def update_wifi_token!
    # self.wifi_token = SecureRandom.uuid
    # self.save!
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
