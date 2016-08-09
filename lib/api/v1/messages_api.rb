module API
  module V1
    class MessagesAPI < Grape::API
      
      helpers API::SharedParams
      
      resource :messages, desc: "消息相关接口" do 
        desc "获取未读消息条数"
        params do
          requires :token, type: String, desc: "用户Token"
        end 
        get :unread_count do
          user = authenticate!
          
          count = Message.unread_for(user).count
          
          { count: count }
        end # end get unread_count
        
        desc "获取消息里列表，并修改消息的状态为已读"
        params do
          requires :token, type: String, desc: "用户Token"
          use :pagination
        end
        get :list do
          user = authenticate!
          
          # 只在第一次加载的时候标记未读消息为已读
          if params[:page].blank? or params[:page].to_i <= 1
            user.update_attribute(:read_sys_msg_at, Time.zone.now)
            Message.where('messages.to = ? and read_at is null', user.id).update_all(read_at: Time.zone.now)
          end
          
          @messages = Message.where('messages.to is null or messages.to = ?', user.id).order('id desc')
          if params[:page]
            @messages = @messages.paginate page: params[:page], per_page: page_size
          end
          
          render_json(@messages, API::V1::Entities::Message)
          
        end # end get list
      end # end resource
      
    end
  end
end