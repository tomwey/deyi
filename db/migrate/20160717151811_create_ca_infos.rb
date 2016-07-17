class CreateCaInfos < ActiveRecord::Migration
  def change
    create_table :ca_infos do |t|
      t.string :comp_name,    null: false
      t.string :comp_address, null: false
      t.string :name   # 联系人
      t.string :mobile # 联系电话
      t.string :email  # 邮箱
      t.string :business_license_no, null: false    # 营业执照号
      t.string :business_license_image, null: false # 营业执照正本
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :ca_infos, :business_license_no
  end
end
