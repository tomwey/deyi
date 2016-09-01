ActiveAdmin.register FollowTask do

  menu parent: 'task'
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#

# t.string :icon,       null: false # 公众号图标
# t.string :gzh_name,   null: false # 公众号名称
# t.string :gzh_id,     null: false # 公众号id
# t.string :gzh_intro
# t.integer :earn, default: 0
# t.text :task_tip,     null: false # 任务攻略
# t.string :dev_secret, null: false # 回调密钥，系统生成
# t.boolean :opened, default: false
# t.integer :sort, default: 0

permit_params :icon, :gzh_name, :gzh_id, :gzh_intro, :earn, :task_tip, :opened, :sort

index do
  selectable_column
  column('ID',:id) { |task| link_to task.id, cpanel_follow_task_path(task) }
  column :icon, sortable: false do |task|
    image_tag task.icon.url(:large), size: '32x32'
  end
  column '公众号信息', sortable: false do |task|
    raw("#{task.gzh_name}<br>#{task.gzh_id}")
  end
  column :earn
  column :task_id, sortable: false
  column :dev_secret, sortable: false
  column :opened
  column :sort
  actions
end

form html: { multipart: true } do |f|
  f.semantic_errors
  
  f.inputs '任务信息' do
    f.input :icon, as: :file, hint: '图片格式为：jpg, jpeg, png, gif；尺寸为：200x200'
    f.input :gzh_name, placeholder: '例如：众盈'
    f.input :gzh_id, placeholder: '例如：zhongying-001'
    f.input :gzh_intro, hint: '公众号简介，20字以内'
    f.input :earn, hint: '大于0的整数'
    f.input :task_tip, as: :text, input_html: { class: 'redactor' }, placeholder: '任务攻略，支持图文混排', hint: '任务攻略，支持图文混排'
    f.input :opened, hint: '是否打开该任务'
    f.input :sort, hint: '值越大，显示越靠前'
  end
  actions
  
end
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end


end
