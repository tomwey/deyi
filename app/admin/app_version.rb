ActiveAdmin.register AppVersion do

  menu priority: 100, label: 'App版本'
  
  # t.string :os, null: false # 系统，值为android或ios
  # t.string :version, null: false # 当前版本
  # t.text :changelog, null: false # 当前版本更新的内容
  # t.string :file # 安装包文件，如果是iOS可以为空
  # t.boolean :must_upgrade, default: true # 是否必须升级该版本
  # t.integer :mode, default: 0 # 该版本用于哪个模式，0表示开发模式，1表示产品模式
  
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :os, :version, :changelog, :file, :must_upgrade, :mode, :opened

index do
  selectable_column
  column 'ID', :id
  column :os, sortable: false
  column :version
  column :changelog, sortable: false
  column '包文件下载地址', sortable: false do |av|
    if av.file
      av.file.url
    else
      ''
    end
  end
  column :must_upgrade, sortable: false
  column :mode, sortable: false
  column :opened, sortable: false
  
  actions
end

form html: { multipart: true } do |f|
  f.semantic_errors
  
  f.inputs do
    f.input :os, as: :select, collection: AppVersion.preferred_os_names, prompt: '-- 选择系统 --'
    f.input :version, placeholder: '例如：1.0.1'
    f.input :file, as: :file, hint: '格式为：apk, ipa'
    f.input :changelog, as: :text, input_html: { class: 'redactor' }, placeholder: '房屋描述，例如：地铁旁好房，有宽带，冰箱，洗衣机，空调等'
    f.input :must_upgrade, hint: '表示当前版本是否要求用户必须升级'
    f.input :mode, as: :radio, collection: AppVersion.preferred_modes, hint: '当前版本用于哪种用途'
    f.input :opened, hint: '只有设置该版本打开，客户端才能拿到该版本升级数据'
  end
  actions
  
end


end
