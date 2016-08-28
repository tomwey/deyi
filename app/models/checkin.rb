class Checkin < ActiveRecord::Base
  belongs_to :user
  
  has_one :earn_log, as: :earnable, dependent: :destroy
  
  scope :today_for_user, -> (user) { where(user_id: user.id, created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day) }
end
