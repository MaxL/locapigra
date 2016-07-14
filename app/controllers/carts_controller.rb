class CartsController < ApplicationController

  def show
    #user
    if current_user
      @user = current_user
    end
    #products
    @order_items = current_order.order_items
    sum = 0
    j = @order_items.map { |e| (sum += e[:total_price]) }
    @subtotal = j[-1]
    if @subtotal
      @subtotal_tax = @subtotal * 0.07
    end
    #order
    @order = current_order
    if !@order.address
      @order.create_address
    end
  end

  def submit_address
    @order = current_order

    respond_to do |format|

      if @order.update_attributes(order_params)
        @order.shipping_cost(order_params[:country])
        @order.shipping = @order.shipping * order_items_quantity
        @order.total = @order.subtotal + @order.shipping
        @order.tax = @order.total * 0.07
        @order.save
        #format.html { redirect_to cart_path, notice: 'Address saved' }
        format.js {}
        format.json { render json: @order, status: :created, location: @order }
        #session.delete :order_id
        #flash[:success] = "Adress saved successfully"
        #redirect_to root_path
      else
        flash[:danger] = "Your order could not be completed"
        redirect_to cart_path
      end
    end

  end

  def checkout
    @order = current_order
    @order.order_status_id = 2
    if @order.update_attributes(order_params)
      if @order.agreement
        @order.save
        session.delete :order_id
        OrderMailer.confirmation_mail(@order).deliver_later
        flash[:success] = "Order placed successfully"
        redirect_to root_path
      else
        flash[:danger] = "Your order could not be completed"
        redirect_to cart_path
      end
    else
      flash[:danger] = "Your order could not be completed"
      redirect_to cart_path
    end
  end

  private
    def order_params
      params.require(:order).permit(:total, :tax, :shipping, :address_id, :agreement, address_attributes: [ :id, :recipient, :street, :city, :zip, :state, :country ])
    end

end
