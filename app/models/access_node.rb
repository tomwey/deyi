class AccessNode < ActiveRecord::Base
  belongs_to :user
  
  belongs_to :wifi_node
end
