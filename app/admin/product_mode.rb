ActiveAdmin.register ProductMode do

  menu parent: 'shop'
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :name, :sort, :need_user_input
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

index do
  selectable_column
  column 'ID', :id
  column :name, sortable: false
  column :need_user_input, sortable: false
  column :sort
  actions
end


end
