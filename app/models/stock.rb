class Stock < ActiveRecord::Base
  validates :name, :product_id, presence: true
  belongs_to :product
  
  after_create :add_product_stock
  def add_product_stock
    product.change_stocks_count(1)
  end
  
  after_destroy :remove_product_stock
  def remove_product_stock
    product.change_stocks_count(-1)
  end 
  
  # 出库
  def do_outgoing
    self.outgoing = true
    self.save!
    product.change_stocks_count(-1)
  end
end
