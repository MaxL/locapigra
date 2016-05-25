class CartsController < ApplicationController

  def show
    @order_items = current_order.order_items
    sum = 0
    j = @order_items.map { |e| (sum += e[:total_price]) }
    @total_price = j[-1]
    @total_tax = @total_price * 0.07
  end

end
