class OrdersController < ApplicationController
  load_and_authorize_resource

  def index
    @orders = Order.all
    @status = OrderStatus.all
    @orders_pending = Order.where(order_status_id: 1)
    @orders_placed = Order.where(order_status_id: 2)
    @orders_paid = Order.where(order_status_id: 3)
    @orders_shipped = Order.where(order_status_id: 4)
    @orders_cancelled = Order.where(order_status_id: 5)
  end

  def show
    @order = Order.find(params[:id])
    @status = OrderStatus.find(@order.order_status_id)
  end

  def edit
    @order = current_order
    if !@order.address
      @order.create_address
    end
  end

  def update
    @order = current_order
    if @order.update_attributes(order_params)
      flash[:success] = "Order placed successfully"
      redirect_to root_path
    else
      flash[:danger] = "Your order could not be completed"
      #redirect_to_root
    end
  end

  private
    def order_params
      params.require(:order).permit(:total, :tax, :shipping, :order_status_id, :address_id, address_attributes: [ :id, :recipient, :street, :city, :zip, :state, :country ])
    end

end
