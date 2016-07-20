class AppType < ActiveRecord::Base
  belongs_to :parent, class_name: 'AppType', foreign_key: 'parent_id'
  
  validates :name, presence: true
  
  mount_uploader :icon, AvatarUploader
  
  def self.preferred_types_for(id)
    types = [['一级分类', nil]]
    AppType.where.not(id: id).each do |type|
      types << [type.name, type.id]
    end
    types
  end
end
