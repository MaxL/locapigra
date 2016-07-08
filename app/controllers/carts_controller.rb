class CartsController < ApplicationController

  def show
    #products
    @order_items = current_order.order_items
    sum = 0
    j = @order_items.map { |e| (sum += e[:total_price]) }
    @subtotal = j[-1]
    if @subtotal
      @subtotal_tax = @subtotal * 0.07
    end
    #delivery

    #order
    @order = current_order
    if !@order.address
      @order.create_address
    end
  end

  def checkout
    @order = current_order
    if @order.update_attributes(order_params)
      @order.order_status_id = 2
      @order.save
      session.delete :order_id
      flash[:success] = "Order placed successfully"
      redirect_to root_path
    else
      flash[:danger] = "Your order could not be completed"
      #redirect_to_root
    end
  end

  private
    def order_params
      params.require(:order).permit(:total, :tax, :shipping, :address_id, address_attributes: [ :id, :recipient, :street, :city, :zip, :state, :country ])
    end

end
