class FilesController < ApplicationController
  skip_authorization_check #only: [:index, :show]
  protect_from_forgery :except => [:clawsoffury]
  before_filter :check_token

  def check_token
    redirect_to :back, :flash => {:error => "Bad link"} if DownloadToken.where("token = ? and expires_at > ?", params[:token], Time.now).nil?
  end

  def clawsoffury
    @token = params[:custom]
    #@token = DownloadToken.create(:expires_at => Time.now + 24.hours)
    redirect_to action: 'download', token: @token
  end

  def download
    @token = params[:token]
  end

  def clawspdf
    send_file 'downloads/clawsoffury.pdf', type: "application/pdf"#, disposition: 'inline'
  end

  def clawsepub
    send_file 'downloads/clawsoffury.epub', type: "application/txt"#, disposition: 'inline'
  end

  def clawscbr
    send_file 'downloads/clawsoffury.cbr', type: "application/txt"#, disposition: 'inline'
  end
end
