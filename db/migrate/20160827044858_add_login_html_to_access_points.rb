class AddLoginHtmlToAccessPoints < ActiveRecord::Migration
  def change
    add_column :access_points, :login_html, :text
  end
end
