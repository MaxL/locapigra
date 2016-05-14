class OrdersController < ApplicationController
  load_and_authorize_resource

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @status = OrderStatus.find(@order.order_status_id)
  end

end
