class WeixinAuthCode < ActiveRecord::Base
  belongs_to :user
  
  before_create :generate_code
  def generate_code
    set_code_and_expired_at
  end
  
  def expired?
    (self.expired_at && Time.zone.now > self.expired_at)
  end
  
  def actived?
    self.actived_at.present?
  end
  
  def unbind!
    self.user_id = nil
    self.actived_at = nil
    self.save!
    
    WithdrawAccount.where(user: self.user, account_id: self.openid).delete_all
  end
  
  def active!
    self.actived_at = Time.zone.now
    self.save!
    
    WithdrawAccount.create!(user: self.user, account_id: self.openid)
  end
  
  def update_auth_code!
    set_code_and_expired_at
    self.save!
  end
  
  def set_code_and_expired_at
    # 生成6位随机码
    begin
      self.code = SecureRandom.hex(3) #if self.nb_code.blank?
    end while self.class.exists?(:code => code)
    
    # 三分钟内有效
    self.expired_at = Time.zone.now + 3.minutes
  end
  
end
