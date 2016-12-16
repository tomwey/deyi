ActiveAdmin.register Stock do

  menu parent: 'shop'
  
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :name, :product_id, :outgoing
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
  column :name, sortable: false
  column '所属产品' do |stock|
    stock.product.try(:title)
  end
  column :outgoing, sortable: false

  actions

end
  

form do |f|
  f.semantic_errors
  
  f.inputs '商品信息' do
    f.input :name, hint: '可以为优惠券的优惠码，或者账号密码', placeholder: '【可以为优惠券，例如：M321DV0980】或者【账号: 13301902341，密码：rdggel】'
    f.input :product_id, as: :select, collection: Product.visible.saled.map { |product| [product.title, product.id] }, prompt: '-- 选择产品 --'
    f.input :outgoing, as: :boolean
  end
  actions
  
end

end
