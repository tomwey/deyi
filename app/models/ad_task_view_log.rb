class AdTaskViewLog < ActiveRecord::Base
  belongs_to :ad_task
  belongs_to :user
  
  after_create :add_ad_task_view_count
  def add_ad_task_view_count
    ad_task.add_view_count
  end
end
