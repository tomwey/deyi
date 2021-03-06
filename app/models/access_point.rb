class AccessPoint < ActiveRecord::Base
  validates :name, :gw_mac, :gw_address, :gw_port, :wmac, presence: true
  belongs_to :wifi_node
  
  before_save :set_gw_id
  def set_gw_id
    self.gw_id = self.gw_mac.gsub(':', '') unless self.gw_mac.blank?
  end
  
  def wifi_node_name
    wifi_node.try(:name)
  end
end
