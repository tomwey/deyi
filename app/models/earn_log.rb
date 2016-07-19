class EarnLog < ActiveRecord::Base
  belongs_to :user
  belongs_to :earnable, polymorphic: true
end
