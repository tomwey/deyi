class Checkin < ActiveRecord::Base
  belongs_to :user
  
  has_one :earn_log, as: :earnable
end
