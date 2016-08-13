class AddEarnTimesToInvites < ActiveRecord::Migration
  def change
    add_column :invites, :earn_times, :integer, default: 0 # 从徒弟那获得收益分成的次数
  end
end
