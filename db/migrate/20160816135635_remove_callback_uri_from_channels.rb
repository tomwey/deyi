class RemoveCallbackUriFromChannels < ActiveRecord::Migration
  def change
    remove_column :channels, :callback_uri
  end
end
