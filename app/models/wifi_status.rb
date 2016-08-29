class WifiStatus < ActiveRecord::Base
  belongs_to :user
  
  before_create :generate_wifi_token
  def generate_wifi_token
    self.token = SecureRandom.uuid.gsub('-', '') if self.token.blank?
  end
  
  def add_login_count
    self.class.increment_counter(:login_count, self.id)
  end
  
  def change_wifi_length!(size)
    total = self.wifi_length + size
    if total >= 0
      self.wifi_length = total
      self.save!
    end
  end
  
end

# t.references :user, index: true, foreign_key: true
# t.string :token
# t.boolean :online, default: false  # 是否正在上网
# t.integer :wifi_length, default: 0 # 剩下的上网时间，单位分钟
# t.integer :login_count, default: 0 # 上网次数
# t.datetime :last_login_at          # 最后一次上网的时间
# t.timestamps null: false
