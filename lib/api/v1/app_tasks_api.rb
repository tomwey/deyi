module API
  module V1
    class AppTasksAPI < Grape::API
      
      helpers API::SharedParams
      
      resource :tasks, desc: '应用任务相关接口' do
        desc '获取任务列表'
        params do
          optional :st, type: Integer, desc: '获取任务的类型，值为0或1，0表示真实用户任务，1表示工作室任务，默认为0'
          optional :uid, type: String, desc: '用户ID或者工作室ID'
        end
        get :home do
          
          st = ( params[:st] || 0 ).to_i
          
          @current_tasks = AppTask.current.filter_for_st(st).sorted.recent
          @after_tasks = AppTask.after.filter_for_st(st).sorted.recent
          
          if @current_tasks.any?
            current_tasks = API::V1::Entities::AppTask.represent(@current_tasks, st: st, ip: client_ip)
          else
            current_tasks = []
          end
          
          if @after_tasks.any?
            after_tasks = API::V1::Entities::AppTask.represent(@after_tasks, st: st)
          else
            after_tasks = []
          end
          
          if params[:uid]
            if st == 0
              u = User.find_by(uid: params[:uid])
            else
              u = Studio.find_by(studio_id: params[:uid])
            end
            if u.blank?
              completed_tasks = []
            else
              # TODO
            end
          else
            completed_tasks = []
          end
          
          { code: 0, message: 'ok', data: { current: current_tasks, after: after_tasks, completed: completed_tasks } }
        end # end get home
        
        desc "抢任务"
        params do
          optional :st, type: Integer, desc: '获取任务的类型，值为0或1，0表示真实用户任务，1表示工作室任务，默认为0'
          requires :uid, type: String, desc: '用户ID或者工作室ID'
        end
        post '/:task_id/grab' do
          st = ( params[:st] || 0 ).to_i
          
          if st == 0
            u = User.find_by(uid: params[:uid])
          else
            u = Studio.find_by(studio_id: params[:uid])
          end
          
          if u.blank?
            return render_error(4004, '账户不存在')
          end
          
          task = AppTask.find_by(task_id: params[:task_id])
          if task.blank?
            return render_error(4004, '任务不存在')
          end
          
          # TODO
        end # end grab
        
        desc "提交任务"
        params do
          optional :st, type: Integer, desc: '获取任务的类型，值为0或1，0表示真实用户任务，1表示工作室任务，默认为0'
          requires :uid, type: String, desc: '用户ID或者工作室ID'
        end
        post '/:task_id/commit' do
          
          st = ( params[:st] || 0 ).to_i
          
          if st == 0
            u = User.find_by(uid: params[:uid])
          else
            u = Studio.find_by(studio_id: params[:uid])
          end
          
          if u.blank?
            return render_error(4004, '账户不存在')
          end
          
          task = AppTask.find_by(task_id: params[:task_id])
          if task.blank?
            return render_error(4004, '任务不存在')
          end
          
          # TODO
          
        end # end commit
        
      end # end resource
      
    end
  end
end