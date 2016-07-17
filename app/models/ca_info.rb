class CaInfo < ActiveRecord::Base
  belongs_to :user
  
  validates :comp_name, :comp_address, 
    :business_license_no, :business_license_image, :user_id, presence: true
    
  mount_uploader :business_license_image, AuthInfoImageUploader
  
end

# t.string :comp_name,    null: false
# t.string :comp_address, null: false
# t.string :name   # 联系人
# t.string :mobile # 联系电话
# t.string :email  # 邮箱
# t.string :business_license_no, null: false    # 营业执照号
# t.string :business_license_image, null: false # 营业执照正本
# t.references :user, index: true, foreign_key: true
