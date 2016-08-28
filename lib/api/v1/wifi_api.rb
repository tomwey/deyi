module API
  module V1
    class WifiAPI < Grape::API
      
      resource :wifi, desc: 'WIFI相关的接口' do
        desc '获取用户的得益wifi信息'
        params do
          requires :token, type: String, desc: '用户Token'
        end
        get :info do
          user = authenticate!
          
          
        end # end get info
        
        desc '连接wifi'
        params do
          requires :token,  type: String, desc: '用户Token'
          requires :gw_mac, type: String, desc: '热点的MAC地址' 
        end
        post :open do
          user = authenticate!
          
          result = user.open_wifi(params[:gw_mac])
          result
        end # end post open
        
        desc '关闭wifi'
        params do
          requires :token,  type: String, desc: '用户Token'
          requires :gw_mac, type: String, desc: '热点的MAC地址' 
        end
        post :close do
        end # end post close
        
      end # end resource
      
    end
  end
end