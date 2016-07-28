class Order < ActiveRecord::Base
  belongs_to :order_status
  has_many :order_items
  has_many :products, through: :order_items
  has_one :address
  before_create :set_order_status, :generate_random_order_number
  before_save :update_subtotal

  accepts_nested_attributes_for :address

  def subtotal
    order_items.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0}.sum
  end

  def set_shipping_price(country)
    @destination = Destination.where(country_code: country)
    self.shipping = @destination.first.shipping_price
  end

  def decrease_inventory
    order_items.each do |order_item|
      puts order_item.product.quantity
      puts order_item.quantity
      if (order_item.product.quantity - order_item.quantity) > 0
        order_item.product.quantity = order_item.product.quantity - order_item.quantity
        order_item.product.save
      end
      puts order_item.product.quantity
    end
  end

  def increase_inventory
    product.quantity = product.quantity + quantity
  end

  private

    def set_order_status
      self.order_status_id = 1
    end

    def generate_random_order_number
      self.order_number = ('A'..'Z').to_a.shuffle[0,8].join
    end

    def update_subtotal
      self[:subtotal] = subtotal
    end
end
