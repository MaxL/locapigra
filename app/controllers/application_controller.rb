class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_order

  def current_order
    if !session[:order_id].nil?
      Order.find(session[:order_id])
    else
      Order.new
    end
  end

  def index_header
    @index_header = true
  end

  private

    def not_authenticated
      flash[:danger] = 'You have to authenticate to access this page'
      redirect_to root_path
    end
end
