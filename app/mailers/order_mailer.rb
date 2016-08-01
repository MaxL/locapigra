class OrderMailer < ApplicationMailer
  before_action :set_delivery_options

  default from: 'info@locapigra.biz'

  def confirmation_mail(order)
    @order = order
    @bank_data = "IBAN: 1234567890 \n BIC: BELADEBEXX \n Arik Jelonnek"

    mail(to: @order.address.email, subject: 'Thank you for your order from l’oca pigra')
  end

  private
    def set_delivery_options
      #code
    end
end
