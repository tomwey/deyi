ActiveAdmin.register Withdraw do

  menu parent: 'earning'
  
  actions :index, :show#, :edit, :update

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params :bean, :fee#, :account_name, :account_num, :account_type
#
# or
#

index do
  selectable_column
  column('ID', :id) { |withdraw| link_to withdraw.id, admin_withdraw_path(withdraw) }
  column '提现类型', sortable: false do |withdraw|
    if withdraw.account_type == 1
      "微信提现"
    elsif withdraw.account_type == 2
      "支付宝提现"
    else
      "未知"
    end
  end
  column :account_name, sortable: false
  column :account_num, sortable: false
  column :bean
  column :fee
  column :state, sortable: false do |withdraw|
    withdraw.state_info
  end
  column '申请时间', :created_at
  column '申请人', sortable: false do |withdraw|
    withdraw.user.try(:nickname) || withdraw.user.try(:mobile)
  end
  
  actions defaults: false do |withdraw|
    item '编辑', edit_cpanel_withdraw_path(withdraw)
    if withdraw.can_cancel?
      item '取消提现 ', cancel_cpanel_withdraw_path(withdraw), method: :put
    end
    if withdraw.can_process?
      item '处理提现 ', processing_cpanel_withdraw_path(withdraw), method: :put
    end
    if withdraw.can_complete?
      item '完成提现 ', complete_cpanel_withdraw_path(withdraw), method: :put
    end
  end
  
end

# 批量取消订单
batch_action :cancel do |ids|
  batch_action_collection.find(ids).each do |target|
    target.cancel
    # order.send_order_state_msg('系统人工取消了您的订单', '已取消')
  end
  redirect_to collection_path, alert: "已经取消"
end

# 批量更改配送状态
batch_action :processing do |ids|
  batch_action_collection.find(ids).each do |target|
    target.process
  end
  redirect_to collection_path, alert: "已经更改为处理中"
end

# 批量完成订单
batch_action :complete do |ids|
  batch_action_collection.find(ids).each do |target|
    target.complete
  end
  redirect_to collection_path, alert: "已经完成订单"
end

member_action :cancel, method: :put do
  resource.cancel
  # resource.send_order_state_msg('系统人工取消了您的订单', '已取消')
  redirect_to collection_path, notice: "已取消"
end

member_action :complete, method: :put do
  resource.complete
  redirect_to collection_path, notice: "已完成"
end

member_action :processing, method: :put do
  resource.process
  redirect_to collection_path, notice: "处理中"
end

form do |f|
  f.semantic_errors
  
  f.inputs '修改提现' do
    f.input :bean
    f.input :fee
  end
  actions
end


end
