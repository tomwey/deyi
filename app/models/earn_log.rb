class EarnLog < ActiveRecord::Base
  belongs_to :user
  belongs_to :earnable, polymorphic: true

  after_create :send_msg
  def send_msg
    Message.create!(title: title, content: "成功#{title}，获得#{earn}益豆", to: user.id)
  end

  # json presentation
  def title
    case self.earnable_type
    when 'Checkin' then '签到'
    else ''
    end
  end
  
  def unit
    '益豆'
  end
  
end
