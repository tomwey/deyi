class Connection < ActiveRecord::Base
  belongs_to :user
  belongs_to :access_node
  
  def expired?
    return false if self.expired_at.blank?
    self.expired_at < Time.now
  end
  
  def used?
    self.used_at.present?
  end
  
  def expire!
    self.expired_at = Time.now
    self.save!
  end
  
  def use!
    self.used_at = Time.now
    self.save!
  end
end
