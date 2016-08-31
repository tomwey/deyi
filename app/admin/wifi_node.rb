ActiveAdmin.register WifiNode do

  menu priority: 13
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

form do |f|
  f.inputs do
    f.input :name, placeholder: '例如：xxxx学校WIFI'
    f.input :address, placeholder: '例如：成都市双流区梨花路33号'
  end
  actions
end


end
