ActiveAdmin.register PaInfo do

menu priority: 5

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
    f.input :name, placeholder: '姓名', hint: '与身份证名字一致'
    f.input :mobile
    f.input :sex, as: :select, collection: PaInfo::SEXES, prompt: '-- 选择性别 --'
    f.input :card_no, placeholder: '身份证号码'
    f.input :card_image, as: :file, hint: '身份证正面图片，格式为：jpg, jpeg, png, gif'
    f.input :card_inverse_image, as: :file, hint: '身份证背面图片，格式为：jpg, jpeg, png, gif'
    f.input :user_id, as: :select, collection: User.verified.map { |u| [u.mobile, u.id] }, prompt: '-- 选择用户 --' 
  end
  
  actions

end


end
