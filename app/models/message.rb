class Message < ActiveRecord::Base
  validates :content, presence: true
  
  belongs_to :user, foreign_key: 'to'
  
  after_create :deliver_msg
  def deliver_msg
    # TODO: 发送消息
  end
  
  def self.unread_for(user)
    if user.read_sys_msg_at.blank?
      where('(messages.to = ? and read_at is null) or (messages.to is null)', user.id)
    else
      where('(messages.to = ? and read_at is null) or (messages.to is null and created_at > ?)', user.id, user.read_sys_msg_at)
    end
  end
end
