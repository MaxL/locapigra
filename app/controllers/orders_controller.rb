class OrdersController < ApplicationController
  #skip_authorization_check only: :confirm
  load_and_authorize_resource except: [:my_orders, :my_order]
  before_filter :no_header, except: [:confirm, :show]

  helper_method :sort_column, :sort_direction

  def index
    @orders = Order.where.not(order_status_id: 1).order("#{sort_column} #{sort_direction}")
    @carts = Order.where(order_status_id: 1).order("#{sort_column} #{sort_direction}")
    @status = OrderStatus.all
    @payments = PaymentChoice.all
  end

  def show
    @order = Order.find(params[:id])
    @status = OrderStatus.find(@order.order_status_id)
  end

  def confirm
    @user = current_user
    @order = @user.orders.last
    @order_items_json = @order.order_items_for_data_layer.to_json
    @bank_owner = ENV["BANK_OWNER"]
    @bank_iban = ENV["BANK_IBAN"]
    @bank_bic = ENV["BANK_BIC"]
  end

  def edit
    @order = Order.find(params[:id])
    if !@order.address
      @order.create_address
    end
  end

  def update
    @order = Order.find(params[:id])
    if @order.update_attributes(order_params)
      if params[:order_status_id] = 4
        @order.shipped_on = DateTime.now
        @order.save
      elsif params[:order_status_id] = 5
        @order.cancelled_on = DateTime.now
      end
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

    def sortable_columns
      ["id", "total", "order_status_id", "placed_on", "updated_at", "payment_choice_id"]
    end

    def sort_column
      sortable_columns.include?(params[:column]) ? params[:column] : "id"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    def order_params
      params.require(:order).permit(:total, :tax, :shipping, :order_status_id, :address_id, address_attributes: [ :id, :recipient, :street, :city, :zip, :state, :country, :email ])
    end

end
