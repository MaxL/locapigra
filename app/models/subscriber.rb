class Subscriber < ActiveRecord::Base
  before_create :set_confirmation_token

  has_many :subscriptions

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  def email_activate
    self.confirmed = true
    self.confirmation_token = nil
    save!(validate: false)
  end

  def set_status status
    self.status = status
    save!(validate: false)
  end

  def translate_status
    status ? "subscribed" : "unsubscribed"
  end

  private
    def set_confirmation_token
      if self.confirmation_token.blank?
        self.confirmation_token = SecureRandom.urlsafe_base64.to_s
      end
    end
end
