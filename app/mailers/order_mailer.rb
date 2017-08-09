class OrderMailer < ApplicationMailer
  before_action :set_delivery_options

  default from: 'shop@locapigra.biz'

  def confirmation_mail(order)
    @order = order
    @payment_choice = PaymentChoice.find(@order.payment_choice_id)
    if @payment_choice != "bankwire"
      @post_order_msg = ""
    else
      @bank_owner = ENV["BANK_OWNER"]
      @bank_iban = ENV["BANK_IBAN"]
      @bank_bic = ENV["BANK_BIC"]
      @post_order_msg = " Please verify the order information above and wire the total sum to \n #{@bank_owner} \n IBAN: #{@bank_iban} \n BIC: #{@bank_bic}"
    end

    mail(to: @order.address.email, cc: [ "info@locapigra.biz" ], bcc: [ ENV["PRIVATE_EMAIL"] ], subject: 'Thank you for your order from l’oca pigra')

  end

  def ebook_mailer(order, attachment)
    @order = order
    attachments['free_book.pdf'] = File.read(attachment)
    mail(to: @order.address.email, cc: [ "info@locapigra.biz" ], bcc: [ ENV["PRIVATE_EMAIL"] ], subject: 'Here\'s the eBook copy of the comic you ordered')
  end

  private
    def set_delivery_options
      #code
    end
end
