class WithdrawAccount < ActiveRecord::Base
  
  validates :account_id, :user_id, presence: true
  validates_uniqueness_of :account_id, scope: :account_type
  
  belongs_to :user
end
