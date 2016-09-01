ActiveAdmin.register CaInfo do

  # menu priority: 4
  menu parent: 'business_auth'
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

form html: { multipart: true } do |f|
  f.semantic_errors
  
  f.inputs do
    f.input :comp_name, placeholder: '公司名称', hint: '与营业执照保持一致'
    f.input :comp_address, placeholder: '公司注册地址', hint: '营业执照上面的注册地址'
    f.input :name, placeholder: '联系人'
    f.input :mobile, placeholder: '联系电话'
    f.input :email, placeholder: '邮箱'
    f.input :business_license_no, placeholder: '营业执照号或统一信用代码'
    f.input :business_license_image, as: :file, hint: '营业执照正本，格式为：jpg, jpeg, png, gif'
    f.input :user_id, as: :select, collection: User.verified.map { |u| [u.mobile, u.id] }, prompt: '-- 选择用户 --' 
  end
  
  actions

end

end
