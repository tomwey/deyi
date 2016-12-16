ActiveAdmin.register AccessPoint do

  # menu priority: 20, label: "WIFI热点"
  menu parent: 'wifi'
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :name, :gw_id, :gw_mac, :gw_address, :gw_port, :login_html, :wmac, :wifi_node_id
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
  column '所属场所', sortable: false do |ap|
    ap.wifi_node_name
  end
  column :gw_id, sortable: false
  column :gw_mac, sortable: false
  column :gw_address, sortable: false
  column :gw_port, sortable: false
  column :wmac, sortable: false
  column :client_count
  actions
end

form html: { multipart: true } do |f|
  f.semantic_errors
  
  f.inputs do
    f.input :name, placeholder: 'SSID', hint: '热点SSID'
    f.input :wifi_node_id, as: :select, label: '所属场所', collection: WifiNode.all.map { |node| [node.name, node.id] }, prompt: '-- 所属场所 --'
    f.input :gw_address
    f.input :gw_port
    f.input :gw_mac, placeholder: '00:00:00:00:00:00'
    f.input :wmac, placeholder: '00:00:00:00:00:00'
    f.input :login_html, as: :text, input_html: { class: 'redactor' }, placeholder: '支持图文混排', hint: '支持图文混排'
  end
  actions
  
end

end
