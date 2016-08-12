class Invite < ActiveRecord::Base
  belongs_to :user, class_name: 'User', foreign_key: 'inviter_id'
  
  after_create :add_earn
  def add_earn
    # 被邀请者获得奖励
    EarnLog.create!(user_id: self.invitee_id,
                    earnable: self,
                    title: '被邀请',
                    subtitle: "成功被邀请，获得#{SiteConfig.invite_earn}益豆",
                    earn: SiteConfig.invite_earn)
  end
end
