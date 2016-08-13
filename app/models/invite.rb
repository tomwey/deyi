class Invite < ActiveRecord::Base
  belongs_to :user, class_name: 'User', foreign_key: 'inviter_id'
  
  after_create :add_earn
  def add_earn
    # 被邀请者获得奖励
    earn = (CommonConfig.invited_earn || 0).to_i
    if earn > 0
      EarnLog.create!(user_id: self.invitee_id,
                      earnable: self,
                      title: '获得邀请',
                      subtitle: "成功被邀请，获得#{earn}益豆",
                      earn: earn)
    end
    
  end
end
