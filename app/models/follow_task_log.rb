class FollowTaskLog < ActiveRecord::Base
  belongs_to :follow_task
  
  after_create :write_earn_log
  def write_earn_log
    if user && earn && earn > 0
      EarnLog.create!(user_id: user.id,
                      earnable: self.follow_task,
                      title: '关注任务',
                      subtitle: "成功关注#{self.follow_task.gzh_name}公众号，获得#{earn}益豆",
                      earn: earn)
    end
  end
  
  def user
    @user ||= User.find_by(nb_code: uid)
  end
end
