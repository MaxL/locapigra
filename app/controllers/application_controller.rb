class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  check_authorization :unless => :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    flash[:danger] = exception.message
    redirect_to root_url
  end

  helper_method :current_order
  helper_method :current_or_guest_user
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

  # if user is logged in, return current_user, else return guest_user
  def current_or_guest_user
    if current_user
      if session[:guest_user_id] && session[:guest_user_id] != current_user.id
        logging_in
        # reload guest_user to prevent caching problems before destruction
        guest_user(with_retry = false).reload.try(:destroy)
        session[:guest_user_id] = nil
      end
      current_user
    else
      guest_user
    end
  end

  # find guest_user object associated with the current session,
  # creating one as needed
  def guest_user(with_retry = true)
    # Cache the value the first time it's gotten.
    @cached_guest_user ||= User.find(session[:guest_user_id] ||= create_guest_user.id)

  rescue ActiveRecord::RecordNotFound # if session[:guest_user_id] invalid
    session[:guest_user_id] = nil
    guest_user if with_retry
  end

  def is_guest_user?
    session[:guest_user_id] && session[:guest_user_id] == current_or_guest_user.id
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

    # called (once) when the user logs in, insert any code your application needs
    # to hand off from guest_user to current_user.
    def logging_in
      # For example:
      # guest_comments = guest_user.comments.all
      # guest_comments.each do |comment|
        # comment.user_id = current_user.id
        # comment.save!
      # end
      orders = guest_user.orders.all
      orders.each do |order|
        order.user_id = current_user.id
        order.save!
        puts order.inspect
      end
    end

    def create_guest_user
      u = User.create(:email => "guest_#{Time.now.to_i}#{rand(100)}@example.com")
      u.save!(:validate => false)
      session[:guest_user_id] = u.id
      u
    end
end
