class AdTask < ActiveRecord::Base
  validates :title, :cover_image, :owner_id, presence: true
  
  validates_numericality_of :price, :share_price, greater_than_or_equal_to: 0
  
  AD_TYPES = [['图片广告', 1], ['网页广告', 2], ['视频广告', 3]]
  
  mount_uploader :cover_image, ImageUploader
  mount_uploaders :ad_contents, AdContentsUploader
  
  scope :opened, -> { where(opened: true) }
  scope :sorted, -> { order('sort desc') }
  scope :recent, -> { order('id desc') }
  scope :no_expired, -> { where('expired_on is NULL or expired_on > ?', 1.days.ago) }
  
  def location_str=(str)
    return if str.blank?
    
    longitude = str.split(',').first
    latitude  = str.split(',').last
    
    self.location = "POINT(#{longitude} #{latitude})"#GEO_FACTORY.point(longitude, latitude)
  end
  
  def location_str
    return '' if self.location.blank?
    "#{self.location.x},#{self.location.y}"
  end
  
  def add_view_count
    self.class.increment_counter(:view_count, self.id)
  end
  
  def open!
    self.opened = true
    self.save!
  end
  
  def close!
    self.opened = false
    self.save!
  end
  
  def self.preferred_merchants
    Admin.all.map { |a| [a.email, a.id] }
  end
  
  def self.list_with_location(lng, lat)
    select("ad_tasks.*, ST_Distance(location, 'SRID=4326;POINT(#{lng} #{lat})'::geometry) as distance").order("distance asc")
  end
  
  def self.nearby(lng, lat, size = 30, order = 'asc')
    
    # 获取附近的查询子表
    subtable = AdTask.order("location <-> 'SRID=4326;POINT(#{lng} #{lat})'::geometry").limit(size).arel_table
    
    # 返回真正的数据并排序
    select("ad_tasks.*, ST_Distance(location, 'SRID=4326;POINT(#{lng} #{lat})'::geometry) as distance").from(subtable).order("distance #{order}")
  end
  
end
