class AdTask < ActiveRecord::Base
  validates :title, :cover_image, :owner_id, presence: true
  
  validates_numericality_of :price, :share_price, greater_than_or_equal_to: 0
  
  AD_TYPES = [['图片广告', 1], ['网页广告', 2], ['视频广告', 3]]
  
  mount_uploader :cover_image, ImageUploader
  mount_uploaders :ad_contents, AdContentsUploader
  
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
  
  def self.preferred_merchants
    Admin.all.map { |a| [a.email, a.id] }
  end
  
end
