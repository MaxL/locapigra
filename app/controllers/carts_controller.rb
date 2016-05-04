class CartsController < ApplicationController

  def show
    puts current_order
    @order_items = current_order.order_items
  end

end
