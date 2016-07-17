class PaInfo < ActiveRecord::Base
  belongs_to :user
  
  validates :name, :card_no, :card_image, :card_inverse_image, :user_id, presence: true
  # validates_uniqueness_of :card_no 考虑用户会传多份资料
  
  mount_uploader :card_image, AuthInfoImageUploader
  mount_uploader :card_inverse_image, AuthInfoImageUploader
  
  SEXES = [['男', 1], ['女', 2]]
  
end

# t.string :name, null: false               # 身份证姓名
# t.string :mobile                          # 电话
# t.integer :sex, default: 1                # 1表示男，2表示女
# t.string :card_no, null: false            # 身份证号
# t.string :card_image, null: false         # 身份证图片正面
# t.string :card_inverse_image, null: false # 身份证背面
# t.references :user, index: true, foreign_key: true
