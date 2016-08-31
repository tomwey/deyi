ActiveAdmin.register WifiLog do

  menu priority: 21, label: "WIFI上网历史"
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
  column 'ID', :id
  column '用户', sortable: false do |log|
    log.user.try(:nickname) || log.user.try(:hack_mobile)
  end
  column '所属WIFI热点', sortable: false do |log|
    "【#{log.access_point.try(:wifi_node_name)}】#{log.access_point.try(:name)}"
  end
  column :used_at#, sortable: false
  column :expired_at#, sortable: false
  column '上网时长' do |log|
    if log.expired_at.blank?
      '--'
    else
      ((log.expired_at - log.used_at).to_i / 60).to_s
    end
  end
  column :ip, sortable: false
  column :mac, sortable: false
  column :incoming_bytes#, sortable: false
  column :outgoing_bytes
  actions
end


end
