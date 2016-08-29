class WifiLog < ActiveRecord::Base
  belongs_to :user
  belongs_to :access_point
  
  def use!
    self.used_at = Time.zone.now
    self.save!
    
    user.connect_wifi!
  end
  
  # 关闭连接
  def close!
    self.expired_at = Time.zone.now
    self.save!
    
    minutes = calcu_delta_minutes
    
    # 更新用户的上网时长
    user.charge_wifi_length!(-minutes)
    
    # 关闭wifi
    user.close_wifi!
  end
  
  def closed?
    self.expired_at.present?
  end
  
  def calcu_delta_minutes
    return 0 if self.used_at.blank? or self.expired_at.blank?
    
    return 0 if self.used_at > self.expired_at
    
    return ( (self.expired_at - self.used_at).to_i / 60 ).to_i
  end
end
