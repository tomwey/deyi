class AddAdNameToChannelCallbackLogs < ActiveRecord::Migration
  def change
    add_column :channel_callback_logs, :ad_name, :string
  end
end
