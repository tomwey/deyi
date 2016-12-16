ActiveAdmin.register WifiStatus do

  menu parent: 'wifi'
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
actions :index

index do
  selectable_column
  column :id
  column :token, sortable: false
  column :wifi_length
  column :login_count
  column :last_login_at
  column '所属用户', sortable: false do |status|
    status.user.try(:nickname) || status.user.try(:mobile)
  end
  column '是否正在上网', sortable: false do |status|
    connection = status.user.try(:current_connection)
    if connection.blank?
      '下线'
    else
      connection.closed? ? '下线' : '在线'
    end
    
  end
end


end
