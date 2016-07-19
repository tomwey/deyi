module API
  module V1
    class CheckinsAPI < Grape::API
      
      helpers API::SharedParams
      
      resource :checkins, desc: '签到接口' do
        desc "创建签到"
        params do
          requires :token,   type: String, desc: "用户认证Token"
          optional :loc,     type: String, desc: "用到当前位置，经纬度坐标，格式为：经度,纬度，例如：104.312321,30.393930"
          use :device_info
        end
        post do
          user = authenticate!
          
          has_record = Checkin.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).count > 0
          return render_error(10001, '今天已经签到过了') if has_record
          
          if params[:loc]
            loc = "POINT(#{params[:loc].gsub(',', ' ')})"
          else
            loc = nil
          end
          
          checkin = Checkin.create!(user_id: user.id, location: loc)
          
          # TODO: 写收益明细
          # EarnLog.create!(user_id: user, earnable: checkin, )
          
          render_json_no_data
        end
      end # end resource
      
    end
  end
end