class ShareTaskLog < ActiveRecord::Base
  belongs_to :share_task
  
  after_create :write_earn_log
  def write_earn_log
    if user && earn && earn > 0
      EarnLog.create!(user_id: user.id,
                      earnable: self.share_task,
                      title: '分享任务',
                      subtitle: "成功分享“#{self.share_task.title}”，获得#{earn}益豆",
                      earn: earn)
      share_task.add_visit
    end
  end
  
  def user
    @user ||= User.find_by(nb_code: uid)
  end
  
end
