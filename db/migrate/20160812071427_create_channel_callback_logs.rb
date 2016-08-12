class CreateChannelCallbackLogs < ActiveRecord::Migration
  def change
    create_table :channel_callback_logs do |t|
      t.string :chn_id # 渠道号
      t.string :order_id # 订单号
      t.string :uid # 用户唯一标识号
      t.integer :earn # 获得的积分
      t.text :params_info # 回调的参数情况
      t.string :result # 回调结果

      t.timestamps null: false
    end
    add_index :channel_callback_logs, [:chn_id, :order_id, :uid], unique: true
    add_index :channel_callback_logs, :uid
    add_index :channel_callback_logs, :chn_id
  end
end
