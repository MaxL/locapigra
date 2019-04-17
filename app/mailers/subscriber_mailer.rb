class SubscriberMailer < ApplicationMailer
  default from: "info@locapigra.biz"

  def registration_confirmation(subscriber)
    @subscriber = subscriber
    mail(to: "#{subscriber.name} <#{subscriber.email}>", subject: "Subscription Confirmation")
  end
end
