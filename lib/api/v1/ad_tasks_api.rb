module API
  module V1
    class AdTasksAPI < Grape::API
      
      helpers API::SharedParams
      
      resource :ad_tasks, desc: "广告收益相关接口" do
        desc "获取广告列表"
        params do
          optional :loc, type: String, desc: "位置坐标，经纬度，值格式为：经度,纬度，例如：104.333122,30.893321"
          optional :sr,  type: String, desc: "指定图片的大小，值为：large, thumb, small中的一个，如果不传该参数默认为large"
          use :pagination
        end
        get :list do
          @tasks = AdTask.opened.no_expired.sorted.recent
          if params[:loc]
            lng,lat = loc.split(',')
            @tasks = @tasks.list_with_location(lng, lat)
          end
          
          @tasks = @tasks.paginate page: params[:page], per_page: page_size
          
          sr = params[:sr] || "large"
          if not %w(large thumb small).include?(sr)
            sr = "large"
          end
          
          render_json(@tasks, API::V1::Entities::AdTask, image_size: sr)
        end # end get list
        desc "根据位置来获取附近的商家广告列表"
        params do
          requires :loc,   type: String,  desc: "位置坐标，经纬度，值格式为：经度,纬度，例如：104.333122,30.893321"
          optional :total, type: Integer, desc: "数量，如果不传该值，默认为30"
          optional :sr,  type: String, desc: "指定图片的大小，值为：large, thumb, small中的一个，如果不传该参数默认为large"
          use :pagination
        end
        get :nearby do
          lng,lat = params[:loc].split(',')
          size = ( params[:total] || 30 ).to_i
          sr = params[:sr] || "large"
          if not %w(large thumb small).include?(sr)
            sr = "large"
          end
          
          @tasks = AdTask.opened.no_expired.nearby(lng,lat,size).sorted.recent
          
          if params[:page]
            @tasks = @tasks.paginate page: params[:page], per_page: page_size
          end
          render_json(@tasks, API::V1::Entities::AdTask, image_size: sr)
        end # end get nearby
        
        desc "点击浏览商家广告"
        params do
          requires :token, type: String, desc: "用户Token"
          requires :ad_id, type: Integer, desc: "返回的广告任务id"
          optional :loc,     type: String, desc: "用到当前位置，经纬度坐标，格式为：经度,纬度，例如：104.312321,30.393930"
          use :device_info
        end
        post :view do
          user = authenticate!
          
        end # end post view
      end # end resource
      
    end
  end
end