class User < ActiveRecord::Base  
  has_secure_password
  
  attr_accessor :money
  
  validates :mobile, :password, :password_confirmation, presence: true, on: :create
  validates :mobile, format: { with: /\A1[3|4|5|7|8][0-9]\d{4,8}\z/, message: "请输入11位正确手机号" }, length: { is: 11 }, :uniqueness => true
            
  mount_uploader :avatar, AvatarUploader
  
  scope :no_delete, -> { where(visible: true) }
  scope :verified,  -> { where(verified: true) }
  
  def hack_mobile
    return "" if self.mobile.blank?
    hack_mobile = String.new(self.mobile)
    hack_mobile[3..6] = "****"
    hack_mobile
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
  
end
