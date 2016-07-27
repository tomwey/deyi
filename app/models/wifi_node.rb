class WifiNode < ActiveRecord::Base
  
  validates :name, :address, presence: true
  
  after_save :parse_address
  def parse_address
    ParseLocJob.perform_later(self)
  end
  
end
