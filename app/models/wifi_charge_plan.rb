class WifiChargePlan < ActiveRecord::Base
  validates :hour, :cost, presence: true
  
  before_create :generate_cid
  def generate_cid
    begin
      self.cid = SecureRandom.hex(8) #if self.nb_code.blank?
    end while self.class.exists?(:cid => cid)
  end
end
