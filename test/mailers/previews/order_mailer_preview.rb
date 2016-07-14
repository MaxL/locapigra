# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview

  def confirmation_mail
    OrderMailer.confirmation_mail(Order.last)
  end

end
