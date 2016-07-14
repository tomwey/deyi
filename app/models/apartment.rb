class Apartment < ActiveRecord::Base
  validates :images, :name, :model, :area, :rental, :title, :u_mobile, :rent_type, presence: true
  
  mount_uploaders :images, ImagesUploader
  
  def location_str=(str)
    # lng, lat = str.split(',')
    # puts str
    # self.location = 'POINT(' + "#{lng}" + ' ' + "#{lat}" + ')'#"POINT(#{lng} #{lat})"
    longitude = str.split(',').first
    latitude  = str.split(',').last
    self.location = 'POINT(' + "#{longitude}" + ' ' + "#{latitude}" + ')'
  end
  
  def location_str
    return '' if self.location.blank?
    "#{self.location.x},#{self.location.y}"
  end
  
end

# t.string  :images, array: true, default: []
# t.string  :name,  null: false         # 小区名字
# t.string  :model, null: false         # 户型
# t.float   :area,   null: false        # 面积，单位为平方
# t.integer :rental, null: false        # 租金
# t.string  :room_type                  # 如果出租类型是单间，那么该值为房间类型
# t.string  :sex_limit                  # 如果出租类型是单间，那么该值为性别限制
# t.string  :title, null: false         # 出租信息标题
# t.text    :body                       # 出租房屋描述
# t.string  :u_name                     # 联系人姓名
# t.string  :u_mobile, null: false      # 联系人手机
# t.string  :rent_type, null: false     # 出租类型
# t.point   :location, geographic: true # 小区的经纬度
# t.string  :address                    # 小区街道地址
# t.boolean :hide_mobile, default: true # 是否隐藏房东的手机号，默认隐藏手机号
# t.boolean :approved, default: true    # 是否审核通过，默认为已审核
