class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.reset_password_email.subject
  #
  def activation_needed_email(user)
    @user = user
    mail(to: user.email, subject: "Account activation")
  end

  def activation_success_email(user)
    @user = user
    mail(to: user.email, subject: 'Account activated')
  end

  def reset_password_email(user)
    @user = User.find user.id
    @url = edit_password_reset_url(@user.reset_password_token)

    mail(to: "to@example.org", subject: "Your password has been reset")
  end
end
