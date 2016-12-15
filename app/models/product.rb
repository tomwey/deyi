class Product < ActiveRecord::Base
  validates :title, :body, :image, :price, presence: true
  validates_numericality_of :price, greater_than_or_equal_to: 0
  validates_uniqueness_of :sku
  
  has_and_belongs_to_many :nodes
  # belongs_to :merchant
  
  mount_uploader :image, ImageUploader
  
  scope :visible, -> { where(visible: true) }
  scope :saled,   -> { where(on_sale: true) }
  scope :sorted,  -> { order('sort desc') }
  scope :hot,     -> { order('orders_count desc, visit_count desc') }
  scope :recent,  -> { order('id desc') }
  
  before_create :generate_sku
  def generate_sku
    begin
      self.sku = '8' + SecureRandom.random_number.to_s[2..8]
    end while self.class.exists?(:sku => sku)
  end
  
  def add_visit
    self.class.increment_counter(:visit_count, self.id)
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
