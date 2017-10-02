class CartsController < ApplicationController
  skip_authorization_check

  TRANSACTION_SUCCESS_STATUSES = [
    Braintree::Transaction::Status::Authorizing,
    Braintree::Transaction::Status::Authorized,
    Braintree::Transaction::Status::Settled,
    Braintree::Transaction::Status::SettlementConfirmed,
    Braintree::Transaction::Status::SettlementPending,
    Braintree::Transaction::Status::Settling,
    Braintree::Transaction::Status::SubmittedForSettlement,
  ]

  def show
    @user = current_or_guest_user
    @order_items = current_order.order_items
    sum = 0
    j = @order_items.map { |e| (sum += e[:total_price]) }
    @subtotal = j[-1]
    if @subtotal
      @subtotal_tax = @subtotal * 0.07
    end
    @order = current_order
    if !@order.address
      @order.create_address
    end
  end

  def submit_address
    @order = current_order
    @user = @order.user
    @client_token = Braintree::ClientToken.generate
    @payment = PaymentChoice.find(order_params[:payment_choice_id])
    respond_to do |format|
      if @order.update_attributes(order_params)
        @order.set_shipping_price(order_params[:address_attributes][:country])
        @order.shipping = @order.shipping * order_items_quantity

        total = @order.subtotal + @order.shipping

        # FIXME get fee from payment option
        if @payment.name == "Braintree"
          fee = ( (total * 100.0) * 0.019 ) + 35.0
          @order.payment_fee = fee.round
        else
          @order.payment_fee = 0
        end

        fee_float = @order.payment_fee / 100.0

        @order.total = total + fee_float
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

  #FIXME modularize checkout method per option? in any case: clean this up!
  def checkout
    @order = current_order
    @order.order_status_id = 2
    if @order.update_attributes(order_params)

      if @order.agreement
        @payment = PaymentChoice.find(@order.payment_choice_id)

        if @payment.name == "Braintree"
          @order.order_status_id = 6
          @order.save
          create_braintree_payment @order.total, @order, params["payment_method_nonce"]

        elsif @payment.name == "Stripe"
          @order.order_status_id = 6
          @order.save
          create_stripe_payment params[:stripeEmail], params[:stripeToken], @order.total, @order

        else
          @order.decrease_inventory
          @order.placed_on = DateTime.now
          @order.save
          session.delete :order_id
          OrderMailer.confirmation_mail(@order).deliver_later
          @token = DownloadToken.create(:expires_at => Time.now + 24.hours)
          flash[:success] = "Order placed successfully"
          if current_user
            redirect_to confirm_order_path(@order, :token => @token.token)
          else
            redirect_to thanks_path :token => @token.token
          end
        end

      else
        flash[:danger] = "Sorry, your order could not be completed"
        redirect_to cart_path
      end

    else
      flash[:danger] = "Sorry, your order could not be completed"
      redirect_to cart_path
    end
  end

  def create_braintree_payment total, order, nonce
    amount = total

    result = Braintree::Transaction.sale(
      amount: amount,
      payment_method_nonce: nonce,
      :options => {
        :submit_for_settlement => true
      }
    )

    if result.success? || result.transaction
      validate_order result.transaction.id
    else
      error_messages = result.errors.map { |error| "Error: #{error.code}: #{error.message}" }
      flash[:error] = error_messages
      redirect_to cart_path
    end
  end

  def create_stripe_payment email, token, total, order
    @amount = total*100

    customer = Stripe::Customer.create(
      email: email,
      source: token
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount.to_i,
      description: 'Locapigra Stripe Customer',
      currency: 'eur'
    )

    validate_stripe_payment
  rescue Stripe::CardError => e
    flash[:danger] = e.message
    redirect_to cart_path
  end

  private
    def order_params
      params.require(:order).permit(:total, :tax, :shipping, :address_id, :agreement, :payment_choice_id, address_attributes: [ :id, :recipient, :street, :city, :zip, :state, :country, :email ])
    end

    def validate_order transaction_id
      @transaction = Braintree::Transaction.find(transaction_id.to_s)
      @result = _create_result_hash(@transaction)
    end

    def _create_result_hash(transaction)
      status = transaction.status

      if TRANSACTION_SUCCESS_STATUSES.include? status
        @order.decrease_inventory
        @order.order_status_id = 3
        @order.placed_on = DateTime.now
        @order.save
        session.delete :order_id
        OrderMailer.confirmation_mail(@order).deliver_later
        @token = DownloadToken.create(:expires_at => Time.now + 24.hours)
        flash[:success] = "Order placed successfully"
        if current_user
          redirect_to confirm_order_path(@order, :token => @token.token)
        else
          redirect_to thanks_path :token => @token.token
        end
      else
        result_hash = {
          :header => "Transaction Failed",
          :icon => "fail",
          :message => "Your test transaction has a status of #{status}. See the Braintree API response and try again."
        }
        flash[:danger] = "Transaction failed: your transaction has a status of #{status}"
        redirect_to cart_path
      end
    end

    def validate_stripe_payment
      @order.decrease_inventory
      @order.order_status_id = 3
      @order.placed_on = DateTime.now
      @order.save
      session.delete :order_id
      OrderMailer.confirmation_mail(@order).deliver_later
      @token = DownloadToken.create(:expires_at => Time.now + 24.hours)
      flash[:success] = "Order placed successfully"
      if current_user
        redirect_to confirm_order_path(@order, :token => @token.token)
      else
        redirect_to thanks_path :token => @token.token
      end
    end

end
