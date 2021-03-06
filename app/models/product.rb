class Product < ActiveRecord::Base
  validates :title, :body, :image, :price, :product_mode_id, presence: true
  validates_numericality_of :price, greater_than_or_equal_to: 0
  validates_uniqueness_of :sku
  
  validate :require_at_least_one_node
  
  has_and_belongs_to_many :nodes
  has_many :stocks
  belongs_to :product_mode
  
  has_one :user_input_config
  accepts_nested_attributes_for :user_input_config, allow_destroy: true#, reject_if: lambda { |c| c.input_label.blank? }
  # belongs_to :merchant
  
  mount_uploader :image, ImageUploader
  
  scope :visible, -> { where(visible: true) }
  scope :saled,   -> { where(on_sale: true) }
  scope :sorted,  -> { order('sort desc') }
  scope :hot,     -> { order('orders_count desc, visit_count desc') }
  scope :recent,  -> { order('id desc') }
  
  def require_at_least_one_node
    if nodes.count == 0
      errors.add(:node_ids,"至少需要选择一个类别")
    end
  end
  
  before_create :generate_sku
  def generate_sku
    begin
      self.sku = '8' + SecureRandom.random_number.to_s[2..8]
    end while self.class.exists?(:sku => sku)
  end
  
  def add_visit
    self.class.increment_counter(:visit_count, self.id)
  end
  
  def change_stocks_count(num)
    count = self.stocks_count += num

    if count >= 0
      # self.stocks_count = count
      # self.save!
      self.update_attribute(:stocks_count, count)
    end
  end
  
  def detail_url
    Setting.upload_url + "/item/#{self.sku}"
  end
  
  # def self.preferred_merchants
  #   merchants = []
  #   merchants << ['系统平台', nil]
  #   Merchant.all.each do |m|
  #     merchants << [m.name, m.id]
  #   end
  #   merchants
  # end
  
  def sale!
    self.on_sale = true
    self.save!
  end
  
  def unsale!
    self.on_sale = false
    self.save!
  end
  
  def hide!
    self.visible = false
    self.save!
  end
  
end

# t.string :title, null: false
# t.text :body,    null: false
# t.integer :price, null: false
# t.integer :sort, default: 0
# t.string :image, null: false
# t.string :sku
# t.integer :orders_count, default: 0
# t.boolean :on_sale, default: false
# t.boolean :visible, default: true
# t.integer :stock, default: 1000 # 库存
# t.boolean :is_virtual_goods, default: false
