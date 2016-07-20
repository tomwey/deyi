ActiveAdmin.register Checkin do

  menu priority: 8
  
  actions :index
  
  index do
    selectable_column
    column 'ID', :id
    column '用户', sortable: false do |c|
      c.user.try(:nickname) || c.user.try(:mobile)
    end
    column '签到益豆', :earn
    column '签到时间', :created_at
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
