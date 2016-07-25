module API
  module V1
    module Entities
      class Base < Grape::Entity
        format_with(:null) { |v| v.blank? ? "" : v }
        format_with(:chinese_date) { |v| v.blank? ? "" : v.strftime('%Y-%m-%d') }
        format_with(:chinese_datetime) { |v| v.blank? ? "" : v.strftime('%Y-%m-%d %H:%M:%S') }
        format_with(:money_format) { |v| v.blank? ? 0 : ('%.2f' % v).to_f }
        expose :id
        # expose :created_at, format_with: :chinese_datetime
      end # end Base
      
      # 用户基本信息
      class UserProfile < Base
        expose :mobile, format_with: :null
        expose :nickname do |model, opts|
          model.nickname || model.mobile
        end
        expose :avatar do |model, opts|
          model.avatar.blank? ? "" : model.avatar_url(:large)
        end
        expose :bean
      end
      
      # 用户详情
      class User < UserProfile
        expose :private_token, as: :token, format_with: :null
      end
      
      # 供应商
      class Merchant < Base
        expose :name
        expose :mobile
        expose :address, format_with: :null
        expose :note, format_with: :null
      end
      
      # 商品
      class Product < Base
        expose :title, :body, :price, :stock, :sku, :is_virtual_goods, :orders_count, :visit_count
        expose :image do |model, opts|
          if model.image.blank?
            ""
          else
            model.image.url(:thumb)
          end
        end
        expose :merchant_name do |model, opts|
          model.merchant.try(:name) || ""
        end
        expose :detail_url
        
      end
      
      # 收货地址
      class Shipment < Base
        expose :name
        expose :hack_mobile, as: :mobile
        expose :address
      end
      
      # 收益明细
      class EarnLog < Base
        expose :title
        expose :earn
        expose :unit
        expose :created_at, as: :time, format_with: :chinese_datetime
      end
      
      # 租房
      class Apartment < Base
        expose :images do |model, opts|
          img_size = opts[:opts][:image_size].to_sym
          model.images.map { |img| img.url(img_size) }
        end
        expose :name, :model, :area, :rental, :rent_type
        expose :title
        expose :body, format_with: :null
        expose :contact_info do
          expose :u_name,   format_with: :null
          expose :u_mobile, format_with: :null
        end
        expose :room_info, if: proc { |apartment| apartment.rent_type == '单间' } do
          expose :room_type
          expose :sex_limit
        end
        expose :location_str, as: :location
        expose :distance do |model, opts|
          model.try(:distance) || 0
        end
        expose :user, using: API::V1::Entities::UserProfile, if: proc { |a| a.user_id.present? }
      end
      
      class PayHistory < Base
        expose :pay_name, format_with: :null
        expose :created_at, format_with: :chinese_datetime
        expose :pay_money do |model, opts|
          if model.pay_type == 0
            "+ ¥ #{model.money}"
          elsif model.pay_type == 1
            "- ¥ #{model.money}"
          else
            if model.pay_name == '打赏别人'
              "- ¥ #{model.money}"
            else
              "+ ¥ #{model.money}" # 收到打赏
            end
          end
        end
      end
      
      class Author < Base
        expose :nickname do |model, opts|
          model.nickname || model.mobile
        end
        expose :avatar do |model, opts|
          model.avatar.blank? ? "" : model.avatar_url(:large)
        end
      end
      
      # Banner
      class Banner < Base
        expose :image do |model, opts|
          model.image.blank? ? "" : model.image.url(:large)
        end
        expose :link, format_with: :null
      end
    
    end
  end
end
