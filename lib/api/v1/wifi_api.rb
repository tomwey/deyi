module API
  module V1
    class WifiAPI < Grape::API
      
      resource :wifi, desc: 'WIFI相关的接口' do
        desc '获取用户的得益wifi信息'
        params do
          requires :token, type: String, desc: '用户Token'
        end
        get :status do
          user = authenticate!
          
          @status = user.wifi_status
          render_json(@status, API::V1::Entities::WifiStatus)
        end # end get info
        
        desc '连接wifi'
        params do
          requires :token,  type: String, desc: '用户Token'
          requires :gw_mac, type: String, desc: '热点的MAC地址' 
        end
        post :open do
          user = authenticate!
          
          # 检测当前账号是否正在上网
          if user.wifi_status.online
            return render_error(20001, "当前账号正在上网，你不能多人同时使用")
          end
          
          # 检测是否有足够的网时
          unless user.has_enough_wifi_length?
            return render_error(20002, "没有足够的上网往时，至少需要#{user.min_allowed_wifi_length}分钟，请充值")
          end
          
          # 如果没有找到热点，直接返回错误提示
          @ap = AccessPoint.where(gw_mac: params[:gw_mac]).first
          if @ap.blank?
            return render_error(20003, "没有找到热点")
          end
          
          # 返回给客户端热点的网关注册地址
          token = user.wifi_status.try(:token)
          if token.blank?
            return render_error(20004, "用户的上网认证Token不存在或生成失败")
          end
          
          # 返回网关注册地址
          { code: 0, link: "http://#{@ap.gw_address}:#{@ap.gw_port}/wifidog/auth?token=#{token}" }
          
        end # end post open
        
        desc '关闭wifi'
        params do
          requires :token,  type: String, desc: '用户Token'
          requires :gw_mac, type: String, desc: '热点的MAC地址' 
        end
        post :close do
          
          user = authenticate!
          
          connection = user.current_connection
          if connection.blank?
            return render_error(20005, "当前用户没有连接wifi")
          end
          
          connection.close!
          
          render_json_no_data
          
        end # end post close
        
      end # end resource
      
    end
  end
end