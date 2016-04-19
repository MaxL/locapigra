class OrderItemsController < ApplicationController

  def create

    @product = Product.find(params[:order_item][:product_id])

    @order = current_order
    if !@order.order_items.exists?(product_id: @product.id)
      @order_item = @order.order_items.new(order_item_params)
      @order_item.quantity += 1
    else
      @order_item = @order.order_items.where(product_id: @product.id).first
      @order_item.increment! :quantity
    end
    @order.save
    session[:order_id] = @order.id
  end

  def update
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.update_attributes(order_item_params)
    @order_items = @order.order_items
  end

  def destroy
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    @order_items = @order.order_items
  end

  private

    def order_item_params
      params.require(:order_item).permit(:quantity, :product_id)
    end

end
