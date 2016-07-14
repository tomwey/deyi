ActiveAdmin.register Apartment do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters

permit_params :name, :model, :area, :rental, :room_type, :sex_limit, :title, :body, :u_name, :u_mobile, :rent_type, :location, :address, :sort, :hide_mobile, { images:[] }

# t.string  :images, array: true, default: []
# t.string  :name,  null: false         # 小区名字
# t.string  :model, null: false         # 户型
# t.float   :area,   null: false        # 面积，单位为平方
# t.integer :rental, null: false        # 租金
# t.string  :room_type                  # 如果出租类型是单间，那么该值为房间类型
# t.string  :sex_limit                  # 如果出租类型是单间，那么该值为性别限制
# t.string  :title, null: false         # 出租信息标题
# t.text    :body                       # 出租房屋描述
# t.string  :u_name                     # 联系人姓名
# t.string  :u_mobile, null: false      # 联系人手机
# t.string  :rent_type, null: false     # 出租类型
# t.point   :location, geographic: true # 小区的经纬度
# t.string  :address                    # 小区街道地址
# t.boolean :hide_mobile, default: true # 是否隐藏房东的手机号，默认隐藏手机号
# t.boolean :approved, default: true    # 是否审核通过，默认为已审核

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

form html: { multipart: true } do |f|
  f.semantic_errors
  
  f.inputs '房屋信息' do
    f.input :images, as: :file, input_html: { multiple: true }, hint: '图片格式为：jpg, jpeg, png, gif'
    f.input :name, placeholder: '例如：蓝光花满庭'
    f.input :model, placeholder: '例如：3-2-1，表示三室二厅一卫', hint: '格式为：室-厅-卫，例如：3-2-1，表示三室二厅一卫'
    f.input :area, placeholder: '例如：120.1', hint: '单位为: 平方'
    f.input :rental, placeholder: '例如：500', hint: '单位为：元，只能是整数'
    f.input :title, placeholder: '房屋简介，例如：绿地三期好房'
    f.input :body, as: :text, placeholder: '房屋描述，例如：地铁旁好房，有宽带，冰箱，洗衣机，空调等'
    f.input :rent_type, as: :select, collection: SiteConfig.rent_types.try(:split, ','), prompt: '-- 请选择出租类型 --'
    f.input :location_str, label: '小区位置', placeholder: '例如：-104.333333,20.122211', hint: '格式为：经度,纬度'
    f.input :address, label: '小区详细地址', placeholder: '例如：成都市金牛区韦家碾一路'
  end
  f.inputs '单间信息', id: 'single-room', style: 'display: none;' do
    f.input :room_type, as: :select, collection: SiteConfig.room_types.try(:split, ','), prompt: '-- 请选择房屋类型 --'
    f.input :sex_limit, as: :select, collection: SiteConfig.sex_limits.try(:split, ','), prompt: '-- 请选择性别 --'
  end
  f.inputs '房东信息' do
    f.input :u_name, placeholder: '例如：张三'
    f.input :u_mobile, placeholder: '例如：13012345678'
    f.input :hide_mobile, hint: '是否隐藏房东的电话'
  end
  actions
  
end

end
