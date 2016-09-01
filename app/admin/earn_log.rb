ActiveAdmin.register EarnLog do

  menu parent: 'earning'
  
  actions :index
  
  index do
    selectable_column
    column 'ID', :id
    column '用户', sortable: false do |e|
      e.user.try(:nickname) || e.user.try(:mobile)
    end
    column '任务', :title, sortable: false
    column '收益说明', :subtitle, sortable: false
    column :earn
    column '收益时间', :created_at
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
