class CartsController < ApplicationController
  skip_authorization_check

  def show
    #user
    @user = current_or_guest_user
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
    @user = @order.user
    respond_to do |format|
      if @order.update_attributes(order_params)
        if is_guest_user?
          @user.email = order_params[:address_attributes][:email]
          @user.save
        end
        @order.set_shipping_price(order_params[:address_attributes][:country])
        @order.shipping = @order.shipping * order_items_quantity
        @order.total = @order.subtotal + @order.shipping
        @order.tax = @order.total * 0.07
        @order.save

        format.js {}
        format.json { render json: @order, status: :created, location: @order }
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
        @order.decrease_inventory
        @order.save
        session.delete :order_id
        OrderMailer.confirmation_mail(@order).deliver_later
        flash[:success] = "Order placed successfully"
        if current_user
          redirect_to confirm_order_path @order
        else
          redirect_to thanks_path
        end
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
      params.require(:order).permit(:total, :tax, :shipping, :address_id, :agreement, address_attributes: [ :id, :recipient, :street, :city, :zip, :state, :country, :email ])
    end

end
