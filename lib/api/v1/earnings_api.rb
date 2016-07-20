module API
  module V1
    class EarningsAPI < Grape::API
      
      helpers API::SharedParams
      
      resource :earnings, desc: '收益接口' do
        
        desc "获取今日收益的益豆总数"
        params do
          requires :token, type: String,  desc: "用户认证Token"
        end
        get :today do
          user = User.find_by(private_token: params[:token])
          
          if user.blank?
            return { count: 0 }
          end
          
          sum = EarnLog.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).sum(:earn)
          
          { count: sum }
        end # end get today
        
        desc "获取收益明细"
        params do
          requires :token, type: String,  desc: "用户认证Token"
          optional :type,  type: Integer, desc: '所属任务类别, 值为: 1到5'
          use :pagination
        end
        get do
          user = authenticate!
          
          @earnings = EarnLog.where(user_id: user.id)
          if params[:page]
            @earnings = @earnings.paginate page: params[:page], per_page: page_size
          end
          
          render_json(@earnings, API::V1::Entities::EarnLog)
        end # end get /
        
      end # end resource
      
    end
  end
end