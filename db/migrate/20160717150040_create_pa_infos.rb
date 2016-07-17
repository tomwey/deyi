class CreatePaInfos < ActiveRecord::Migration
  def change
    create_table :pa_infos do |t| # 个人认证信息
      t.string :name, null: false               # 身份证姓名
      t.string :mobile                          # 电话
      t.integer :sex, default: 1                # 1表示男，2表示女
      t.string :card_no, null: false            # 身份证号
      t.string :card_image, null: false         # 身份证图片正面
      t.string :card_inverse_image, null: false # 身份证背面
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :pa_infos, :card_no#, unique: true 考虑到有可能用户会传多份资料
  end
end
