class OrderMailer < ApplicationMailer
  before_action :set_delivery_options

  default from: 'shop@locapigra.biz'

  def claws_mail(token)
    @token = token

    mail(to: @order.address.email, cc: [ "info@locapigra.biz" ], bcc: [ ENV["PRIVATE_EMAIL"] ], subject: 'Thank you for your order from l’oca pigra')

  end

  private
    def set_delivery_options
      #code
    end
end
