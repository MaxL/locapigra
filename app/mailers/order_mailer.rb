class OrderMailer < ApplicationMailer
  before_action :set_delivery_options

  default from: 'shop@locapigra.biz'

  def confirmation_mail(order)
    @order = order
    @bank_owner = ENV["BANK_OWNER"]
    @bank_iban = ENV["BANK_IBAN"]
    @bank_bic = ENV["BANK_BIC"]
    @bank_data = "#{@bank_owner} \n IBAN: #{@bank_iban} \n BIC: #{@bank_bic}"

    mail(to: @order.address.email, subject: 'Thank you for your order from l’oca pigra')
  end

  private
    def set_delivery_options
      #code
    end
end
