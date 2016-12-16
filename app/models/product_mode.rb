class ProductMode < ActiveRecord::Base
  validates :name, presence: true
end
