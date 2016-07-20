ActiveAdmin.register EarnLog do

  menu priority: 9
  
  actions :index
  
  index do
    selectable_column
    column 'ID', :id
    column '用户', sortable: false do |e|
      e.user.try(:nickname) || e.user.try(:mobile)
    end
    column '任务', :title, sortable: false
    column :earn
    column '收益时间', :created_at
    column :model, sortable: false
    column :platform, sortable: false
    column :screen_size
    column :udid, sortable: false
    column :os_version
    column :app_version
    column :country_language, sortable: false
    column :ip_addr, sortable: false
    column :network_type, sortable: false
    column :is_broken, sortable: false do |e|
      e.is_broken ? '是' : '否'
    end
  end
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end


end
