class ChangeColumnsForChannelCallbackLogs < ActiveRecord::Migration
  def change
    remove_column :channel_callback_logs, :params_info
    add_column :channel_callback_logs, :callback_params, :string, array: true, default: []
  end
end
