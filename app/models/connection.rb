class Connection < ActiveRecord::Base
  belongs_to :user
  belongs_to :access_node
end
