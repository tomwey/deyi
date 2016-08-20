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
          
          { count: user.today_beans }
        end # end get today
        
        desc "获取收益明细"
        params do
          requires :token, type: String,  desc: "用户认证Token"
          optional :type,  type: Integer, desc: '所属任务类别, 值为: 1到6, 分别对应联盟任务，签到任务，关注任务，分享任务，广告任务，收徒'
          use :pagination
        end
        get do
          user = authenticate!
          
          @earnings = EarnLog.where(user_id: user.id).order('id desc')
          if params[:type]
            index = [( params[:type].to_i - 1 ), 0].max
            types = %w(Channel Checkin FollowTask ShareTask AdTask InviteEarn)
            index = [index, types.count].min
            @earnings = @earnings.where(earnable_type: types[index].to_s)
          end
          if params[:page]
            @earnings = @earnings.paginate page: params[:page], per_page: page_size
          end
          
          render_json(@earnings, API::V1::Entities::EarnLog)
        end # end get /
        
      end # end resource
      
    end
  end
end