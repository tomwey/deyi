class Withdraw < ActiveRecord::Base
  belongs_to :withdraw_account
  belongs_to :user
  
  validates :user_id, :bean, :account_name, :account_num, presence: true
  
  after_create :change_user_balance
  def change_user_balance
    user.change_balance!(-(self.bean + self.fee))
  end
  
  def restore_change_balance
    user.change_balance!(self.bean + self.fee)
    
    # TODO: 发送提醒消息
  end
  
  def state_info
    I18n.t("common.#{state}")
  end
  
  # 定义状态机
  state_machine initial: :pending do # 默认状态
    state :processing # 提现中
    state :canceled   # 已取消
    state :completed  # 已完成
    
    # 提现
    after_transition :pending => :processing do |withdraw, transition|
      # order.send_pay_msg
    end
    event :process do
      transition :pending => :processing
    end
    
    # 取消
    after_transition :processing => :canceled do |withdraw, transition|
      # order.send_pay_msg
      withdraw.restore_change_balance
    end
    event :cancel do
      transition :processing => :canceled
    end
    
    # 完成提现
    after_transition :processing => :completed do |withdraw, transition|
      # order.send_pay_msg
    end
    event :complete do
      transition :processing => :completed
    end
    
  end
  
end
