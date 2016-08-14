class FollowTasksController < ApplicationController

  def show
    nb_code = params[:uid]
    @user = User.find_by(nb_code: nb_code)
    @task = FollowTask.find(params[:id])
  end
  
  # 回调
  def callback
    # 任务ID
    task_id = params[:task_id]
    
    # uid
    nb_code = params[:uid]
    
    # 时间戳
    time = params[:time]
    
    # 签名
    sig = params[:sig]
    
    
    user = User.find_by(nb_code: nb_code)
    task = FollowTask.find_by(task_id: task_id)
    if task.blank? or user.blank?
      render json: { message: '未找到数据', success: false }
      return
    end
    
    if not task.opened
      render json: { message: '您的任务已经下架', success: false }
      return
    end
    
    str = task.dev_secret + task_id + nb_code + time.to_s
    signature = Digest::MD5.hexdigest(str)
    
    if signature == sig
      count = FollowTaskLog.where(uid: nb_code, follow_task_id: task.id).count
      if count == 0
        cb_params = []
        params.each do |k,v|
          cb_params << "#{k}=#{v}"
        end
        if FollowTaskLog.create(uid: nb_code, 
                                follow_task_id: task.id,
                                earn: task.earn,
                                callback_params: cb_params)
          render json: { message: '成功', message: true }
        else
          render json: { message: '失败', message: false }
        end
      else
        render json: { message: '已经成功回调一次', message: true }
      end
      
    else
      render json: { message: '参数校验失败', success: false }
    end
  end
    
end