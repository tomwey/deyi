ActiveAdmin.register Product do

  # menu priority: 8
  menu parent: 'shop'
  # t.string :title, null: false
  # t.text :body,    null: false
  # t.integer :price, null: false
  # t.integer :sort, default: 0
  # t.string :image, null: false
  # t.string :sku
  # t.integer :orders_count, default: 0
  # t.boolean :on_sale, default: false
  # t.boolean :visible, default: true
  # t.integer :stock, default: 1000 # 库存
  # t.boolean :is_virtual_goods, default: false
  
  permit_params :title, :body, :image, :sort, :price, :stocks_count, :product_mode_id, { node_ids: [] }, user_input_config_attributes: [:id, :input_label, :input_placeholder, :_destroy]#, :is_virtual_goods, :merchant_id,

index do
  selectable_column
  column('ID',:id) { |product| link_to product.id, cpanel_product_path(product) }
  column(:sku, sortable: false) { |product| link_to product.sku, cpanel_product_path(product) }
  column :image, sortable: false do |product|
    image_tag product.image.url(:small)
  end
  column :title, sortable: false
  column :price
  column :orders_count
  column :stocks_count
  # column :is_virtual_goods, sortable: false
  # column '供应商', sortable: false do |product|
  #   product.merchant.try(:name) || '系统'
  # end

  actions defaults: false do |product|
    item "编辑", edit_cpanel_product_path(product)
    if product.on_sale
      item "下架", unsale_cpanel_product_path(product), method: :put
    else
      item "上架", sale_cpanel_product_path(product), method: :put
    end
    item "删除", hide_cpanel_product_path(product), method: :put, data: { confirm: '你确定吗？' }
  end

end
  
# 批量执行
batch_action :unsale do |ids|
  batch_action_collection.find(ids).each do |product|
    product.unsale!
  end
  redirect_to collection_path, alert: "已经下架"
end

batch_action :sale do |ids|
  batch_action_collection.find(ids).each do |product|
    product.sale!
  end
  redirect_to collection_path, alert: "已经上架"
end

batch_action :hide do |ids|
  batch_action_collection.find(ids).each do |product|
    product.hide!
  end
  redirect_to collection_path, alert: "已经删除"
end

member_action :sale, method: :put do
  resource.sale!
  redirect_to collection_path, notice: "已上架"
end

member_action :unsale, method: :put do
  resource.unsale!
  redirect_to collection_path, notice: "已下架"
end

member_action :hide, method: :put do
  resource.hide!
  redirect_to collection_path, notice: "已删除"
end

show do
  attributes_table do
    row :title
    row :body do |product|
      raw(product.body)
    end
  end
end

form html: { multipart: true } do |f|
  f.semantic_errors

  f.inputs '产品基本信息' do
    f.input :image, as: :file, hint: '图片格式为：jpg, jpeg, png, gif；尺寸为：750x512'
    f.input :title
    f.input :price, placeholder: '例如：100', hint: '值为大于0的整数'
    f.input :node_ids, as: :check_boxes, collection: Node.all.map { |node| [node.name, node.id] }, required: true
    f.input :product_mode_id, as: :select, collection: ProductMode.all.map { |mode| [mode.name, mode.id] }, required: true, prompt: '-- 选择产品模式 --' 
  end
  # f.inputs '产品模式配置' do
  #   f.has_many [:user_input_config, f.object.user_input_config || UserInputConfig.new], new_record: false, heading: false do |c|
  #     c.input :input_label, placeholder: '例如：手机号或者网易通行证号'
  #     c.input :input_placeholder, placeholder: '例如：输入您的手机号或者输入网易通行证号'
  #   end
  # end
  f.inputs '产品模式配置', id: 'user-input-config', style: "#{(f.object.new_record? or f.object.user_input_config.blank?) ? 'display: none' : ''}" do
    f.semantic_fields_for :user_input_config, (f.object.user_input_config || UserInputConfig.new) do |c|
      # c.inputs do
        c.input :input_label, placeholder: '例如：手机号或者网易通行证号'
        c.input :input_placeholder, placeholder: '例如：输入您的手机号或者输入网易通行证号'
        c.input :_destroy, as: :boolean, required: false, label: '删除配置'
      # end
    end
  end

  f.inputs '产品详细信息' do
    f.input :body, as: :text, input_html: { class: 'redactor' }, placeholder: '商品详情，支持图文混排', hint: '商品详情，支持图文混排'
  end
  f.inputs '其他信息' do
    f.input :stocks_count, hint: '库存，值为整数'
    # f.input :merchant_id, as: :select, collection: Product.preferred_merchants, hint: '选择所属供应商，如果不选择，表示供应商为我们系统平台自己', prompt: '-- 选择供应商 --'
    # f.input :is_virtual_goods, hint: '该商品是否是虚拟商品'
    f.input :sort, hint: '值越大，显示越靠前'
  end
  actions

end

end
