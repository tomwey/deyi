ActiveAdmin.register WifiChargePlan do

  menu parent: 'wifi'

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :hour, :cost
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
    f.input :hour, placeholder: '正整数', hint: '单位为小时'
    f.input :cost, placeholder: '正整数', hint: '单位为益豆'
  end
  actions
end


end
