ActiveAdmin.register_page "Dashboard" do

  menu priority: 0, label: proc{ I18n.t("active_admin.dashboard") }

  content title: '最新数据统计' do
    
    # 最新提现申请
    columns do  
      column do
        panel "最新提现申请" do
          table_for Withdraw.where(state: ['pending', 'processing']).order('id desc').limit(20) do
            column 'ID', :id
            column '申请人' do |withdraw|
              withdraw.user.try(:nickname) || withdraw.user.try(:mobile)
            end
            column '提现账户名', :account_name
            column '提现账号', :account_num
            column '提现方式' do |withdraw|
              withdraw.account_type == 1 ? '微信提现' : '支付宝提现'
            end
            column '提现益豆', :bean
            column '提现手续费', :fee
            column '状态' do |withdraw|
              withdraw.state_info
            end
            column '申请时间', :created_at
          end
        end
      end # end
    end
    
    # 最新收益日志
    columns do
      column do
        panel "最新任务收益" do
          table_for EarnLog.order('id desc').limit(20) do
            column 'ID', :id
            column :title#, sortable: false
            column '任务内容', :subtitle, sortable: false
            column :earn
            column '获得收益时间', :created_at
          end
        end
      end # end 
    end
    
    # 最新用户
    columns do
      column do
        panel "最新用户" do
          table_for User.order('id desc').limit(20) do
            column :id
            column :avatar, sortable: false do |u|
              u.avatar.blank? ? "" : image_tag(u.avatar.url(:normal))
            end
            column :uid, sortable: false
            column :nickname, sortable: false
            column :mobile, sortable: false
            column 'Token', sortable: false do |u|
              u.private_token
            end
            column '益豆' do |u|
              u.bean
            end
            column '余额' do |u|
              u.balance
            end
            column '剩余网时' do |u|
              "#{u.wifi_status.try(:wifi_length)}分钟"
            end
            column :verified, sortable: false
            column :created_at
          end
        end
      end # end 
    end
    
    # div class: "blank_slate_container", id: "dashboard_default_message" do
    #   span class: "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
