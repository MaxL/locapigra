class FilesController < ApplicationController
  skip_authorization_check #only: [:index, :show]
  protect_from_forgery :except => [:clawsoffury]
  before_action :check_token, except: [:clawsoffury]

  def clawsoffury
    @token = params[:custom]
    #@token = DownloadToken.create(:expires_at => Time.now + 24.hours)
    redirect_to action: 'download', token: @token
  end

  def download
    @token = params[:token]
  end

  def clawspdf
    send_file('#{ENV["RAILS_SHARED_ROOT"]}/downloads/clawsoffury.pdf',
>>>>>>> 615febd7e2c6def6dc75ec7bbc01c75491023da1
              filename: "clawsoffury.pdf",
              type: "application/pdf"
    )
  end

  def clawsepub
    send_file('#{ENV["RAILS_SHARED_ROOT"]}/downloads/clawsoffury.epub',
>>>>>>> 615febd7e2c6def6dc75ec7bbc01c75491023da1
              filename: "clawsoffury.epub"
    )
  end

  def clawscbr
    send_file('#{ENV["RAILS_SHARED_ROOT"]}/downloads/clawsoffury.cbr',
              filename: "clawsoffury.cbr"
    )
>>>>>>> 615febd7e2c6def6dc75ec7bbc01c75491023da1
  end

  private
  def check_token
    redirect_to root_path, :flash => {:danger => "Bad link"} unless DownloadToken.where("token = ? and expires_at > ?", params[:token], Time.now).present?
  end
end
