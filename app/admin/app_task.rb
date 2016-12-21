ActiveAdmin.register AppTask do

  menu parent: 'deyi'
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :app_id, :name, :keywords, :task_steps, :special_price, :start_time, :end_time, :sort, :price, :put_in_count, :st_price, :st_put_in_count
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

form do |f|
  f.semantic_errors
  f.inputs '任务基本信息' do
    f.input :app_id, as: :select, collection: App.all.map { |app| [app.name, app.id] }, prompt: '-- 选择应用 --', required: true
    f.input :name
    f.input :keywords
    f.input :task_steps, as: :text, input_html: { class: 'redactor' }, placeholder: '任务步骤，支持图文混排', hint: '任务步骤，支持图文混排'
    f.input :special_price, placeholder: '0.2', hint: '单位为元'
    f.input :start_time, as: :string, placeholder: '2016-10-10 16:00:00'
    f.input :end_time, as: :string, placeholder: '2016-10-10 16:00:00'
    f.input :sort
  end
  f.inputs '真实用户任务信息' do
    f.input :price, placeholder: '1.7', hint: '单位为元'
    f.input :put_in_count, placeholder: '1000'
  end
  f.inputs '工作室任务信息' do
    f.input :st_price, placeholder: '0.8', hint: '单位为元'
    f.input :st_put_in_count, placeholder: '200'
  end
  actions
end


end

# name: '任务名称'
# keywords: '关键字'
# task_steps: '任务步骤'
# price: '真实用户价格'
# st_price: '工作室价格'
# put_in_count: '用户任务量'
# st_put_in_count: '工作室任务量'
# grab_count: '用户完成量'
# st_grab_count: '工作室完成量'
# start_time: '任务开始时间'
# end_time: '任务结束时间'
# task_id: '任务ID'
# special_price: '专属任务或非100%奖励扣除'
# app: '所属应用'
# app_id: '所属应用'
# sort: '显示顺序'
