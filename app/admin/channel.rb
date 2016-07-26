ActiveAdmin.register Channel do

menu priority: 12

permit_params :name, :support_os, :title, :subtitle, :sort, :icon, :ios_app_name, :ios_app_id, :ios_app_secret, :ios_other, :android_app_name, :android_app_id, :android_app_secret, :android_other, :user_param, :point_param,
:app_id_param, :app_name_param, :ip_param, :success_return, :fail_return, :callback_uri

index do
  selectable_column
  column('ID',:id)
  column '图标', sortable: false do |channel|
    if channel.icon
      image_tag channel.icon.url(:large), size: '40x40'
    else
      ''
    end
  end
  column '名称', sortable: false do |channel|
    "#{channel.name} #{channel.title}(#{channel.subtitle})"
  end
  column '支持的系统', sortable: false do |channel|
    channel.support_os_info
  end
  column :sort
  column :callback_uri, sortable: false
  column '状态', sortable: false do |channel|
    if channel.opened
      '已打开'
    else
      '已关闭'
    end
  end
  
  actions defaults: false do |channel|
    item "编辑", edit_admin_channel_path(channel)
    if channel.opened
      item "关闭", close_admin_channel_path(channel), method: :put
    else
      item "打开", open_admin_channel_path(channel), method: :put
    end
    item "删除", admin_channel_path(channel), method: :delete, data: { confirm: '你确定吗？' }
  end
end

# 批量执行
batch_action :close do |ids|
  batch_action_collection.find(ids).each do |target|
    target.close!
  end
  redirect_to collection_path, alert: "已经关闭"
end

batch_action :open do |ids|
  batch_action_collection.find(ids).each do |target|
    target.open!
  end
  redirect_to collection_path, alert: "已经打开"
end

member_action :close, method: :put do
  resource.close!
  redirect_to collection_path, notice: "已关闭"
end

member_action :open, method: :put do
  resource.open!
  redirect_to collection_path, notice: "已打开"
end

form html: { multipart: true } do |f|
  f.semantic_errors
  
  f.inputs '渠道信息' do
    f.input :name, as: :select, collection: Channel.preferred_names, prompt: '-- 选择渠道名称 --'
    f.input :support_os, as: :select, collection: Channel.preferred_support_os, prompt: '-- 选择支持的系统 --'
    f.input :title, placeholder: '例如：100益豆=1元'
    f.input :subtitle, placeholder: '例如：积分高★★★'
    f.input :icon, as: :file, hint: '图片格式为：jpg, jpeg, png, gif, 正方形尺寸就行'
    f.input :sort, hint: '值为整数，值越大显示越靠前'
    # f.input :callback_uri, placeholder: '例如：/callback', 
  end
  f.inputs '回调参数' do
    f.input :user_param, placeholder: '例如：userid', hint: '回调中确定下载用户的用户名参数,以OpenID为准'
    f.input :point_param, placeholder: '例如：point', hint: '回调中确定下载获得积分数量'
    f.input :app_id_param, placeholder: '例如：appName', hint: '回调中确定下载应用ID的参数'
    f.input :app_name_param, placeholder: '例如：appName', hint: '回调中确定下载应用名称的参数'
    f.input :ip_param, placeholder: '', hint: '接收渠道回调验证IP,为空表示不验证'
  end
  
  f.inputs '返回结果' do
    f.input :success_return, placeholder: '例如：success', hint: '渠道回调成功以后返回字符串'
    f.input :fail_return, placeholder: '例如：false', hint: '渠道回调失败以后返回字符串'
  end
  
  f.inputs 'iOS接入配置', id: 'ios-config', style: 'display: none;' do
    f.input :ios_app_name, placeholder: '应用名称', hint: '渠道建应用名称,如为空则不填写'
    f.input :ios_app_id, placeholder: '渠道应用AppId', hint: '渠道建应用APPID,如为空则不填写'
    f.input :ios_app_secret, placeholder: '渠道应用AppSecret', hint: '渠道建应用AppSecret,如为空则不填写'
    f.input :ios_other, hint: '渠道建应用其它选项,如为空则不填写'
  end
  
  f.inputs 'Android接入配置', id: 'android-config', style: 'display: none;' do
    f.input :android_app_name, placeholder: '应用名称', hint: '渠道建应用名称,如为空则不填写'
    f.input :android_app_id, placeholder: '渠道应用AppId', hint: '渠道建应用APPID,如为空则不填写'
    f.input :android_app_secret, placeholder: '渠道应用AppSecret', hint: '渠道建应用AppSecret,如为空则不填写'
    f.input :android_other, hint: '渠道建应用其它选项,如为空则不填写'
  end

  actions
  
end


end
