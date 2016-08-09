class AddTitleToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :title, :string, default: '系统消息'
  end
end
