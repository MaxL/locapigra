class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_order
  helper_method :order_items_quantity

  def current_order
    if !session[:order_id].nil?
      if Order.find_by_id(session[:order_id])
        Order.find_by_id(session[:order_id])
      else
        Order.new
      end
    else
      Order.new
    end
  end

  def order_items_quantity
    if current_order
      #grouped = current_order.order_items.group_by { |el| el["quantity"] }
      #sum = 0
      #ar = grouped.map { |e, f| sum += e }
      #res = ar[-1]
      h = current_order.order_items
      sum = 0
      j = h.map { |e| (sum += e[:quantity].to_i) }
      j[-1]
    end
  end

  def index_header
    @index_header = true
  end

  def no_header
    @no_header = true
  end

  private

    def not_authenticated
      flash[:danger] = 'You have to authenticate to access this page'
      redirect_to root_path
    end
end
