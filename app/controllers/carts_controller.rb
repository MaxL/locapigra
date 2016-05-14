class CartsController < ApplicationController

  def show
    @order_items = current_order.order_items
    sum = 0
    j = @order_items.map { |e| (sum += e[:total_price]) }
    @total_price = j[-1]
    @total_tax = @total_price * 0.07
  end

  def update
    @order = current_order

    if @order.update_attributes(order_params)
      flash[:success] = "Order placed successfully"
      redirect_to_root
    else
      flash[:danger] = "Your order could not be completed"
      redirect_to_root
    end
  end

  private
    def order_params
      params.require(:order).permit(:total, :tax, :shipping, :order_status_id, :address_id, address_attributes: [:recipient, :street, :city, :zip, :state, :country])
    end

end
