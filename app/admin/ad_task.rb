ActiveAdmin.register AdTask do

  menu priority: 13
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :title, :subtitle, :cover_image, :location_str, :address, :price, :share_price, :ad_type, :ad_link, :expired_on, :sort, :owner_id, { ad_contents: [] }

index do
  selectable_column
  column('ID',:id) { |ad| link_to ad.id, admin_ad_task_path(ad) }
  column(:title, sortable: false) { |ad| link_to ad.title, admin_ad_task_path(ad) }
  column :cover_image, sortable: false do |ad|
    if ad.cover_image.blank?
      ''
    else
      image_tag ad.cover_image.url(:small)
    end
  end
  column :ad_type, sortable: false do |ad|
    %w(图片广告 网页广告 视频广告)[ad.ad_type - 1]
  end
  column :price
  column :share_price
  column :expired_on
  column '所属商家', sortable: false do |ad|
  end
  column :opened, sortable: false do |ad|
    ad.opened ? '打开' : '关闭'
  end
  column :sort
  column :created_at
  column :updated_at
  
  actions
  
  # actions defaults: false do |product|
  #   item "编辑", edit_admin_product_path(product)
  #   if product.on_sale
  #     item "下架", unsale_admin_product_path(product), method: :put
  #   else
  #     item "上架", sale_admin_product_path(product), method: :put
  #   end
  # end
  
end

show do
  attributes_table do
    row :title
    row :subtitle
    row :ad_contents do |ad|
      # ul do
      html = ''
      ad.ad_contents.each do |img|
        html += image_tag(img.url)
      end
      raw(html)
      # end
    end
    row :ad_link
    
  end
end

form html: { multipart: true } do |f|
  f.semantic_errors
  
  f.inputs '商家广告基本信息' do
    f.input :title
    f.input :subtitle, hint: '广告描述，200字以内'
    f.input :cover_image, as: :file, hint: '图片格式为：jpg, jpeg, png, gif，尺寸：750x512'
    f.input :ad_type, as: :select, collection: AdTask::AD_TYPES, prompt: '-- 选择商家广告类别 --'
    f.input :ad_contents, as: :file, wrapper_html: { class: 'ad-contents', style: "#{f.object.ad_type != 2 ? "" : "display: none;"}" }, input_html: { multiple: true }, hint: '支持图片广告或视频广告上传，支持多个文件上传，图片格式为：jpg, jpeg, png, gif, 视频格式为：mp4, mov等'
    f.input :ad_link, wrapper_html: { class: 'ad-link', style: "#{f.object.ad_type == 2 ? "" : "display: none;"}" }, placeholder: '例如：http://www.baidu.com', hint: '网页广告的地址，只有广告类型为网页广告时，该值是必填'
    f.input :location_str, label: '商家广告位置', placeholder: '例如：-104.333333,20.122211', hint: '格式为：经度,纬度'
    f.input :price, placeholder: '例如：500', hint: '只能是整数'
    f.input :share_price, placeholder: '例如：500', hint: '只能是整数'
    f.input :expired_on, as: :string, placeholder: '例如：2016-08-01', hint: '过期日期，格式为：年-月-日 (yyyy-mm-dd)'
    f.input :owner_id, as: :select, collection: AdTask.preferred_merchants, prompt: '-- 选择商家 --'
    f.input :sort, hint: '值越大显示越靠前'
  end
    
  actions
  
end

end
