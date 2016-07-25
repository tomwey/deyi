class Merchant < ActiveRecord::Base
  validates :name, :mobile, presence: true
end
