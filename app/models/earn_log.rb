class EarnLog < ActiveRecord::Base
  belongs_to :user
  belongs_to :earnable, polymorphic: true

  TASK_TYPES = %w(Channel Checkin FollowTask ShareTask AdTask InviteEarn)

  after_create :do_some_important
  def do_some_important
    # 更新用户的余额
    add_user_earn
    
    # 添加师傅的收益，并且只分成一级师徒关系
    add_inviter_earn if earnable_type != 'InviteEarn'
    
    # 发送收益消息
    Message.create!(title: title, content: subtitle, to: user.id)
    
    # 发送即时推送消息，推送到app主页
    # send_real_msg
    send_msg
    
  end
  
  def self.task_name(type)
    I18n.t("common.#{type.underscore}")
  end
  
  def add_user_earn
    if earn && earn > 0
      user.bean += earn
      user.balance += earn
      user.save!
    end
  end
  
  def add_inviter_earn
    # 只有三分积分墙以及百分百收益参与分成
    unless %w(Channel AppTask).include?(earnable_type)
      return
    end
    
    return if user.inviter_id.blank?
    
    inviter = user.inviter
    return if inviter.blank?
    
    # 获取一个徒弟的任务分成次数是有限的
    key   = "#{inviter.uid}:#{user.uid}"
    count = $redis.get(key).to_i
    
    max_count = (CommonConfig.max_earn_times || 10).to_i
    if count == max_count
      $redis.del(key)
      return
    end
    
    # 开始计数
    count = count + 1
    $redis.set(key, count)
    
    # 保存积分
    update_inviter_earn_for(inviter)
  end
  
  def update_inviter_earn_for(inviter)
    # 分成比例
    earn_factor = (CommonConfig.share_earn_factor || 0.2).to_f
    
    # 最大分成积分
    max_share_earn = (CommonConfig.max_share_earn || 1000).to_i
    
    # 计算后的分成收益
    share_earn = (user.earn * earn_factor).to_i + 1
    
    # 最多分成10元
    share_earn = [share_earn, max_share_earn].min
    
    # 保存收益
    if share_earn > 0
      InviteEarn.create!(user_id: inviter.id, invitee_id: self.id, earn: share_earn)
    end
    
  end
  
  def send_msg
    white_list_types = %(Channel FollowTask ShareTask InviteEarn)
    PushService.push_to(subtitle, ["#{user.uid}"]) if white_list_types.include?(self.earnable_type)
  end

  # json presentation
  # def title
  #   case self.earnable_type
  #   when 'Checkin' then '签到'
  #   else ''
  #   end
  # end
  
  def unit
    '益豆'
  end
  
end
