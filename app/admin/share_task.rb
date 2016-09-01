ActiveAdmin.register ShareTask do

  menu parent: 'task'
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#

permit_params :icon, :title, :earn, :first_open_earn, :quantity, :link, :share_content, :share_icon, :share_link, :opened, :sort

index do
  selectable_column
  column('ID',:id) { |task| link_to task.id, cpanel_share_task_path(task) }
  column :icon, sortable: false do |task|
    image_tag task.icon.url(:large), size: '32x32'
  end
  column :title, sortable: false
  column :earn
  column :first_open_earn
  column :quantity
  column :visit_count
  column :link, sortable: false
  column :share_link, sortable: false do |task|
    "#{task.share_link}?i=#{task.task_id}"
  end
  column :share_content, sortable: false do |task|
    if task.share_content
      task.share_content
    else
      raw("#{task.title}<br>#{task.share_link}?i=#{task.task_id}")
    end
  end
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
    f.input :title
    f.input :earn, hint: '大于0的整数'
    f.input :first_open_earn, hint: '大于0的整数'
    f.input :quantity, hint: '大于0的整数'
    f.input :link, placeholder: 'http://', hint: '地址全路径，例如：http://www.baidu.com/'
    f.input :opened, hint: '是否打开该任务'
    f.input :sort, hint: '值越大，显示越靠前'
  end
  f.inputs '微信分享信息' do
    f.input :share_icon, as: :file, hint: '图片格式为：jpg, jpeg, png, gif；尺寸为：200x200'
    f.input :share_link, placeholder: 'http://', hint: 'url地址，例如：http://www.baidu.com/'
    f.input :share_content, placeholder: '可以为空', hint: '如果不填入该值，默认为：任务标题+分享链接'
  end
  actions
  
end

end

# t.string :icon,     null: false
# t.string :title,    null: false
# t.integer :earn, default: 0
# t.integer :first_open_earn, default: 0
# t.integer :quantity, default: 0
# t.string :link, null: false
# t.string :share_content
# t.string :share_link, null: false
# t.string :share_icon, null: false
# t.integer :sort, default: 0
# t.boolean :opened, default: false