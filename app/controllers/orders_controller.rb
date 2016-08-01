class OrdersController < ApplicationController
  load_and_authorize_resource
  before_filter :no_header, except: [:confirmation]

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

  def confirm
    #code
  end

  def edit
    @order = Order.find(params[:id])
    if !@order.address
      puts "NO ADDRESS"
      @order.create_address
    else
      puts @order.address.recipient
    end
  end

  def update
    @order = Order.find(params[:id])
    if @order.update_attributes(order_params)
      flash[:success] = "Order updated successfully"
      redirect_to orders_path
    else
      flash[:danger] = "Your order could not be completed"
      #redirect_to_root
    end
  end

  def destroy
    Order.find(params[:id]).destroy
    flash[:success] = "Order deleted"
    redirect_to orders_path
  end

  private
    def order_params
      params.require(:order).permit(:total, :tax, :shipping, :order_status_id, :address_id, address_attributes: [ :id, :recipient, :street, :city, :zip, :state, :country, :email ])
    end

end
