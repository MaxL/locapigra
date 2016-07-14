class Order < ActiveRecord::Base
  belongs_to :order_status
  has_many :order_items
  has_one :address
  before_create :set_order_status
  before_save :update_subtotal

  accepts_nested_attributes_for :address

  def subtotal
    order_items.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0}.sum
  end

  def shipping_cost(country)
    case country
    when "DE"
      self.shipping = 2.6
    when "AT"
      self.shipping = 4.99
    else
      self.shipping = 2.6
    end
  end

  private

    def set_order_status
      self.order_status_id = 1
    end

    def update_subtotal
      self[:subtotal] = subtotal
    end
end
