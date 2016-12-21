class AddAppPriceToApps < ActiveRecord::Migration
  def change
    add_column :apps, :app_price, :string, default: '0.00'
  end
end
