class Order < ActiveRecord::Base
  belongs_to :product, counter_cache: true
  belongs_to :user
end
