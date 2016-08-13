class ChannelCallbackLog < ActiveRecord::Base
  after_create :create_earn_log
  def create_earn_log
    if earn && earn > 0
      EarnLog.create!(user_id: user.id,
                      earnable: channel,
                      title: channel.name,
                      subtitle: "成功下载#{ad_name}，获得#{earn}益豆",
                      earn: earn)
    end
  end
  
  def user
    User.find_by(uid: self.uid)
  end
  
  def channel
    Channel.where('android_app_id = :app_id or ios_app_id = :app_id', app_id: chn_id).first
  end
  
end
