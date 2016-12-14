class Order < ActiveRecord::Base
  resourcify

  extend FriendlyId
  friendly_id :order_number, use: [:slugged, :finders]

  belongs_to :order_status
  belongs_to :user
  has_many :order_items
  has_many :products, through: :order_items
  has_one :address
  has_one :payment
  before_create :set_order_status, :generate_random_order_number
  before_save :update_subtotal

  accepts_nested_attributes_for :address

  serialize :notification_params, Hash

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

  def associate_with_user user
    self.user_id = user.id
  end

  def order_items_for_data_layer
    order_items_for_data_layer = {}
    order_items.each do |order_item|
      full_item_price = order_item.quantity * order_item.unit_price
      order_items_for_data_layer[:sku] = order_item.id
      order_items_for_data_layer[:name] = order_item.product.name
      order_items_for_data_layer[:category] = 'Comics'
      order_items_for_data_layer[:price] = full_item_price.to_f
      order_items_for_data_layer[:quantity] = order_item.quantity
    end
    order_items_for_data_layer
  end

  def paypal_checkout

    order_item_list = order_items.all.map { |u| [u.id, u] }.to_h

    puts order_item_list

    require 'paypal-sdk-rest'

    @payment = PayPal::SDK::REST::Payment.new({
      :intent =>  "sale",

      # ###Payer
      # A resource representing a Payer that funds a payment
      # Payment Method as 'paypal'
      :payer =>  {
        :payment_method =>  "paypal" },

      # ###Redirect URLs
      :redirect_urls => {
        :return_url => "http://localhost:3000/hook",
        :cancel_url => "http://localhost:3000/" },

      # ###Transaction
      # A transaction defines the contract of a
      # payment - what is the payment for and who
      # is fulfilling it.
      :transactions =>  [{

        # Item List
        :item_list => {
          :items => [

          ]},

        # ###Amount
        # Let's you specify a payment amount.
        :amount =>  {
          :total =>  total,
          :currency =>  "EUR" },
        :description =>  "Your purchase at locapigra." }]})

    # Create Payment and return status
    if @payment.create
      # Redirect the user to given approval url
      @redirect_url = @payment.links.find{|v| v.method == "REDIRECT" }.href
      logger.info "Payment[#{@payment.id}]"
      logger.info "Redirect: #{@redirect_url}"
    else
      logger.error @payment.error.inspect
    end
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
