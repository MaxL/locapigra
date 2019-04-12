class MessageMailer < ApplicationMailer
  before_action :set_delivery_options

  def contact(request)
    @message = JSON.parse request
    puts @message
    mail(to: "info@locapigra.biz", bcc: [ ENV["PRIVATE_EMAIL"] ], subject: 'Message about a commission')
  end

  private
    def set_delivery_options
      #code
    end
end
