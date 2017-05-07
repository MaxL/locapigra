class DownloadToken < ActiveRecord::Base

  before_create :generate_token

  def generate_token
    self.token = SecureRandom.base64(15).tr('+/=lIO0', 'abc123')
  end
end
