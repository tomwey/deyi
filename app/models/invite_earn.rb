class InviteEarn < ActiveRecord::Base
  belongs_to :user
  
  after_create :write_earn_log
  def write_earn_log
    if earn && earn > 0 && invited_user
      EarnLog.create!(user_id: user.id,
                      earnable: self,
                      title: '收徒收益',
                      subtitle: "获得徒弟(ID #{invited_user.uid})任务分成收益#{earn}益豆",
                      earn: earn)
    end
  end
  
  def invited_user
    @user ||= User.find_by(id: invitee_id)
  end
end
