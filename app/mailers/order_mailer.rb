class OrderMailer < ApplicationMailer
  before_action :set_delivery_options

  default from: 'shop@locapigra.biz'

  def confirmation_mail(order)
    @order = order
    if @order.payment_id == 1
      @post_order_msg = ""
    else
      @bank_owner = ENV["BANK_OWNER"]
      @bank_iban = ENV["BANK_IBAN"]
      @bank_bic = ENV["BANK_BIC"]
      @post_order_msg = " Please verify the order information above and wire the total sum of #{number_to_currency @order.total, locale: :de} to \n #{@bank_owner} \n IBAN: #{@bank_iban} \n BIC: #{@bank_bic}"
    end

    mail(to: @order.address.email, subject: 'Thank you for your order from l’oca pigra')
  end

  private
    def set_delivery_options
      #code
    end
end
