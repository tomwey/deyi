class UserInputConfig < ActiveRecord::Base
  belongs_to :product
  
  validates :input_label, presence: true
end
